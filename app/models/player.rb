class Player < ActiveRecord::Base
  belongs_to :owner, :foreign_key => :user_id
  
  has_many :player_apps
  has_many :apps, :through => :player_apps
  
  has_many :score_trackers
  has_many :time_trackers

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "48x48>" },
                             :url =>  "upload/images/:class/:attachment/:id/:style.:extension",
                             :path => ":rails_root/public/upload/images/:class/:attachment/:id/:style.:extension"

  def as_json(options={})
    {:device_identifier => device_identifier, :language => language, :name => name,
      :gender => gender, :time_between_pause => time_between_pause, :break_duration => break_duration,
      :time_to_pause => time_to_pause, :time_to_break => time_to_break, :weekday_time => weekday_time,
      :weekend_time => weekend_time}
  end
end
