class ClientApplication < ActiveRecord::Base
  include OAuth::Helper
  RATINGS = [4, 9, 12]
  PER_GAME_TIME = 30

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

  def time_summary(parent, child)
    {:game_left_time => current_left_time(parent, child), :total_left_time => total_left_time(parent, child)}
  end

  def current_left_time(parent, child)
    rule_definition = rule_definitions.find_by_parent_id_and_period(parent.id, 'day')
    rule_day_time = rule_definition ? rule_definition.time : PER_GAME_TIME
    play_day_time = child.time_trackers.sum('time', :conditions => ["client_application_id = ? and created_at >= ?", self.id, Time.now.beginning_of_day])
    rule_day_time - play_day_time
  end

  def total_left_time(parent, child)
    total_time = parent.total_time
    play_total_time = child.time_trackers.sum('time', :conditions => ["created_at >= ?", Time.now.beginning_of_day])
    total_time - play_total_time
  end
end
