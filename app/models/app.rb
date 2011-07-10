class App < ActiveRecord::Base
  include OAuth::Helper

  has_many :player_apps
  has_many :players, :through => :player_apps
  
  belongs_to :category
  belongs_to :developer, :foreign_key => :user_id
  
  has_many :time_trackers
  has_many :score_trackers

  validates :name,  :presence => true, :uniqueness => true, :length => { :maximum => 100 }
  validates :description, :presence => true
  validates :screenshot,  :presence => true, :unless => :new_record?
  validates :app_store_url,  :presence => true, :unless => :new_record?
  validates :category_id,  :presence => true
  validates :price,  :presence => true


  has_attached_file :screenshot, :styles => {:default => "100x100>"}
  has_attached_file :icon, :styles => {:default => "156x156>"}

  scope :except, lambda { |app_id| where("id != ?", app_id) }
  scope :random, lambda { |number| order("RAND()").limit(number) }

  before_create :generate_keys

  def to_exchange
    {:name => name, :description => description, :app_store_url => app_store_url, :icon_url => full_icon_url(:default)}
  end

  def full_icon_url(style_name)
    "#{RAILS_HOST}/public#{icon.url(style_name)}"
  end

  def generate_keys
    self.key ||= generate_key(16)
    self.secret ||= generate_key(32)
  end

end
