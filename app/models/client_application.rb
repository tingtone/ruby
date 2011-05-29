class ClientApplication < ActiveRecord::Base
  include OAuth::Helper
  RATINGS = [4, 9, 12]

  belongs_to :developer
  belongs_to :client_application_category


  has_many :rule_definitions, :foreign_key => 'client_application_id'
  accepts_nested_attributes_for :rule_definitions

  has_many :time_trackers, :foreign_key => 'client_application_id'
  has_many :time_trackers

  validates_presence_of :name, :description
  validates_uniqueness_of :name
  validates_uniqueness_of :identifier

  before_create :generate_keys


  def as_json(options={})
    {:id => id, :name => name}
  end

  def category_name
    client_application_category.try(:name)
  end

  def generate_keys
    self.key = generate_key(16)
    self.secret = generate_key(32)
  end

  def time_summary(child)
    RuleDefinition::PERIODS.keys.inject({}) do |summary, period|
      summary.merge({ :"game_#{period}_left_time" => send("#{period}_left_time", child) })
    end.merge({:total_left_time => total_left_time(child)})
  end

  RuleDefinition::PERIODS.each do |period, time|
    class_eval <<-EOS
      def #{period}_left_time(child)
        rule_definition = rule_definitions.find_by_child_id_and_period(child.id, "#{period}")
        rule_day_time = rule_definition ? rule_definition.time : #{time}
        play_day_time = child.time_trackers.sum('time', :conditions => ["client_application_id = ? and created_at >= ?", self.id, Time.now.beginning_of_#{period}])
        rule_day_time - play_day_time
      end
    EOS
  end

  def total_left_time(child)
    total_time = child.total_time
    play_total_time = child.time_trackers.sum('time', :conditions => ["created_at >= ?", Time.now.beginning_of_day])
    total_time - play_total_time
  end
end
