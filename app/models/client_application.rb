class ClientApplication < ActiveRecord::Base
  include OAuth::Helper
  RATINGS = [4, 9, 12]

  belongs_to :developer
  belongs_to :client_application_category


  has_many :rule_definitions
  accepts_nested_attributes_for :rule_definitions

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
      summary.merge({
        :"game_#{period}_left_time" => child.send("#{period}_left_time", self),
        :"total_#{period}_left_time" => child.send("total_#{period}_left_time")
      })
    end
  end

  class << self

    def recommands(parent)
       ClientApplication
    end

    def filter_list(params)

    end

  end


end
