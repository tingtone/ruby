class Player < ActiveRecord::Base
  belongs_to :owner, :foreign_key => :user_id
  
  has_many :player_apps
  has_many :apps, :through => :player_apps
  
  has_many :score_trackers
  has_many :time_trackers

  validates :device_identifier, :presence => true, :uniqueness => true

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "48x48>" }
  
  

  def as_json(options={})
    {:device_identifier => device_identifier, :language => language, :name => name,
      :gender => gender, :time_between_pause => time_between_pause, :pause_duration => pause_duration,
      :time_between_breaks => time_between_breaks,:break_duration => break_duration,
      :time_to_pause => time_to_pause, :time_to_break => time_to_break, :weekday_time => weekday_time,
      :weekend_time => weekend_time, :birthday => birthday.to_datetime.to_i,
      :time_left => time_left,
      :timestamp => timestamp}
  end

  def add_app(app)
    unless self.player_apps.find_by_app_id(app.id)
      self.player_apps.create(:app => app)
    end
  end
  
  def age
    return (Date.today.year - birthday.year)
  end #age
  
  def is_pay?
    !expired_timestamp.nil?
  end #is_pay
  
  def iap_payment?(current_app)
    payment_method = PlayerApp.find_by_app_id_and_player_id(current_app.id, player_id).payment_method
    case payment_method
    when 'iap'
      true
    else
      false
    end
  end
  
  def web_payment(current_app)
    payment_method = PlayerApp.find_by_app_id_and_player_id(current_app.id, player_id).payment_method
    case payment_method
    when 'iap'
      false
    when 'paypal'
      true
    when 'zhifubao'
      true
    else
      false
    end
  end
end
