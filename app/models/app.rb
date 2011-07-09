class App < ActiveRecord::Base
  has_many :player_apps
  has_many :players, :through => :player_apps
  
  belongs_to :category
  belongs_to :developer, :foreign_key => :user_id
  
  has_many :time_trackers
  has_many :score_trackers
end
