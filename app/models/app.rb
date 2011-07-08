class App < ActiveRecord::Base
  has_many :player_apps
  has_many :players, :through => :player_apps
  
  has_many :score_trackers
  has_many :players, :through => :score_trackers
  
  has_many :time_trackers
  has_many :players, :through => :time_trackers
  
  belongs_to :category
  belongs_to :developer, :foreign_key => :user_id
  
end
