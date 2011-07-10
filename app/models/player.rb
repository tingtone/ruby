class Player < ActiveRecord::Base
  belongs_to :owner, :foreign_key => :user_id
  
  has_many :player_apps
  has_many :apps, :through => :player_apps
  
  has_many :score_trackers
  has_many :time_trackers

  def as_json(options={})
    {:device_identifier => device_identifier, :language => language, :name => name,
      :gender => gender, :time_between_pause => time_between_pause, :break_duration => break_duration,
      :time_to_pause => time_to_pause, :time_to_break => time_to_break, :weekday_time => weekday_time,
      :weekend_time => weekend_time}
  end

  def add_app(app)
    unless self.player_apps.find_by_app_id(app.id)
      self.player_apps.create(:app => app)
    end
  end
end
