class App < ActiveRecord::Base
  has_many :player_apps
  has_many :players, :through => :player_apps
  
  belongs_to :category
  belongs_to :developer, :foreign_key => :user_id
  
  has_many :time_trackers
  has_many :score_trackers

  has_attached_file :screenshot, :styles => {:default => "100x100>"}
  has_attached_file :icon, :styles => {:default => "156x156>"}

  scope :except, lambda { |app_id| where("id != ?", app_id) }
  scope :random, lambda { |number| order("RAND()").limit(number) }

  def to_exchange
    {:name => name, :description => description, :app_store_url => app_store_url, :icon_url => full_icon_url(:default)}
  end

  def full_icon_url(style_name)
    "#{RAILS_HOST}/public#{icon.url(style_name)}"
  end
end
