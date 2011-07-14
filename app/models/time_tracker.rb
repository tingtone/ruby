class TimeTracker < ActiveRecord::Base
  belongs_to :player
  belongs_to :app
  
  
  def self.played_time(current_player, params)
    last_tt = current_player.try(:time_trackers).try(:last)
    last_timestamp = last_tt.try(:timestamp)
    week = Time.at(params[:timestamp].to_i).stamp("Sunday")
    if last_tt.blank? || (last_tt && last_timestamp.to_i < params[:timestamp].to_i)
      if week == 'Sunday' || week == 'Saturday'
        time = current_player.weekend_time.to_i - params[:time_left].to_i
      else
        time = current_player.weekday_time.to_i - params[:time_left].to_i
      end
    elsif last_tt && last_timestamp.to_i == params[:timestamp].to_i
      time = current_player.time_left.to_i - params[:time_left].to_i
    else
      time = -1
    end
    return time
  end #self.played_time
end
