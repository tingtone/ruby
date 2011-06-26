class ClientApplication < ActiveRecord::Base
  include OAuth::Helper
  RATINGS = [4, 9, 12]

  belongs_to :developer
  has_many :client_application_categories
  has_many :categories, :through => :client_application_categories, :source => :category

  has_many :client_application_languages
  has_many :languages, :through => :client_application_languages, :source => :language

  has_many :rule_definitions
  accepts_nested_attributes_for :rule_definitions

  has_many :time_trackers

  validates_presence_of :name, :description
  validates_uniqueness_of :name
  validates_uniqueness_of :identifier

  validates_presence_of :start_age, :unless => :new_record?
  validates_presence_of :end_age, :unless => :new_record?
  validates_presence_of :icon, :unless => :new_record?
  validates_presence_of :screenshot, :unless => :new_record?
  validates_presence_of :app_store_url, :unless => :new_record?

  before_create :generate_keys

  has_attached_file :screenshot, :styles => {:default => "100x100>"}
  has_attached_file :icon, :styles => {:default => "156x156>"}

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
end
