class App < ActiveRecord::Base
  include OAuth::Helper

  has_many :player_apps
  has_many :players, :through => :player_apps
  
  belongs_to :category
  belongs_to :developer, :foreign_key => :user_id
  
  has_many :time_trackers
  has_many :score_trackers
  
  validates :name,  :presence => true, :uniqueness => true, :length => { :maximum => 100 }
  # validates :description, :presence => true
  # validates :screenshot,  :presence => true, :unless => :new_record?
  validates :app_store_url,  :presence => true, :uniqueness => true, :app_store_url_format => true
  validates :category_id,  :presence => true
  # validates :price,  :presence => true

  serialize :language, Array
  
  # has_attached_file :screenshot, :styles => {:default => "100x100>"}
  # has_attached_file :icon, :styles => {:default => "156x156>"}

  scope :except, lambda { |app_id| where("id != ?", app_id) }
  scope :random, lambda { |number| order("RAND()").limit(number) }
  scope :valid_apps, where("app_store_url is not NULL")


  before_create :generate_keys
  
  before_save :fetch_app_info_from_itnues
  # def to_exchange
  #     {:name => name, :description => description, :app_store_url => app_store_url, :icon_url => full_icon_url(:default)}
  #   end
  # 
  #   def full_icon_url(style_name)
  #     "#{RAILS_HOST}/public#{icon.url(style_name)}"
  #   end

  def generate_keys
    self.key ||= generate_key(16)
    self.secret ||= generate_key(32)
  end

  def belong_to_current_developer?(developer)
    self.developer.id.to_i == developer.id.to_i
  end

  def fetch_app_info_from_itnues
      url = self.app_store_url
      app = Crawler.new url
      self.description = app.app_desc
      self.rated = app.app_rated.split(' ').second.chop.to_i
      self.support_device = App.support_device_option(app.app_requirements)
      self.price = app.app_price
      self.language = app.app_lang.split(': ').last.split(', ')
      self.icon_path = app.app_icon
  end #fetch_app_info_from_itnues
  
  # def language=(langs)
  #     write_attribute(:language, langs)
  #   end #language=(langs)
  
  def self.support_device_option(requirements)
    if requirements.match(/iPad/) && requirements.match(/iPhone/)
      'iPad/iPhone'
    elsif requirements.match(/iPhone/)
      'iPhone'
    elsif requirements.match(/iPad/)
      'iPad'
    end
  end #support_device_option
end
