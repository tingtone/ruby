class GameApplication < ClientApplication
  RATINGS = [4, 9, 12]

  has_many :rule_definitions, :foreign_key => 'client_application_id'

  accepts_nested_attributes_for :rule_definitions
  has_many :time_trackers, :foreign_key => 'client_application_id'

  def time_summary(parent, child)
    {:game_left_time => current_left_time(parent, child), :total_left_time => total_left_time(parent, child)}
  end

  def current_left_time(parent, child)
    rule_day_time = rule_definitions.find_by_parent_id_and_period(parent.id, 'day').time
    play_day_time = child.time_trackers.sum('time', :conditions => ["client_application_id = ? and created_at >= ?", self.id, Time.now.beginning_of_day])
    rule_day_time - play_day_time
  end

  def total_left_time(parent, child)
    total_time = parent.total_time.to_i
    play_total_time = child.time_trackers.sum('time', :conditions => ["created_at >= ?", Time.now.beginning_of_day])
    total_time - play_total_time
  end
end
