class Player < ActiveRecord::Base
  belongs_to :owner, :foreign_key => :user_id
  
  has_many :player_apps
  has_many :apps, :through => :player_apps
  
  # has_many :score_trackers
  #   has_many :apps, :through => :score_trackers
  #   
  #   has_many :time_trackers
  #   has_many :apps, :through => :time_trackers
end
