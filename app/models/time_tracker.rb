class TimeTracker < ActiveRecord::Base
  belongs_to :player
  belongs_to :app
  
  
  def self.played_time(current_player, params)
    last_tt = current_player.try(:time_trackers).try(:last)
    last_timestamp = last_tt.try(:timestamp)
    week = Time.at(params[:timestamp].to_i).stamp("Sunday")
    params_day  = Time.at(params[:timestamp].to_i).stamp("1900-01-01")
    db_store_day = Time.at(last_timestamp.to_i).stamp("1900-01-01")
    
    if last_tt.blank? || (last_tt && params_day != db_store_day)
      if week == 'Sunday' || week == 'Saturday'
        time = current_player.weekend_time.to_i - params[:time_left].to_i
      else
        time = current_player.weekday_time.to_i - params[:time_left].to_i
      end
    elsif last_tt && params_day == db_store_day
      time = current_player.time_left.to_i - params[:time_left].to_i
    else
      time = -1
    end
    return time
  end #self.played_time
end
