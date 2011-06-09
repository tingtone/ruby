class Child < ActiveRecord::Base
  validates_presence_of :fullname, :gender, :birthday
  belongs_to :parent
  belongs_to :grade
  has_many :time_trackers
  has_many :score_trackers
  has_many :rule_definitions
  has_many :achievements
  has_many :bonus
  accepts_nested_attributes_for :rule_definitions

  def as_json(options={})
    {:id => id, :fullname => fullname, :gender => gender, :birthday => birthday.to_time.to_i}
  end

  def birthday=(seconds_with_frac)
    if seconds_with_frac.is_a? Date
      write_attribute(:birthday, seconds_with_frac)
    else
      write_attribute(:birthday, Time.at(seconds_with_frac.to_i).to_date)
    end
  end

  RuleDefinition::PERIODS.each do |period, time|
    class_eval <<-EOS
      def #{period}_left_time(client_application)
        rule_definition = rule_definitions.find_by_client_application_id_and_period(client_application.id, "#{period}")
        rule_time = rule_definition ? rule_definition.time : #{time}
        play_time = time_trackers.sum('time', :conditions => ["client_application_id = ? and created_at >= ?", client_application.id, Time.now.beginning_of_#{period}])
        rule_time - play_time + bonus_time
      end
    EOS
  end

  RuleDefinition::GLOBAL_PERIODS.each do |period, time|
    class_eval <<-EOS
      def total_#{period}_left_time
        rule_definition = rule_definitions.find_by_client_application_id_and_period(nil, "#{period}")
        total_time = rule_definition ? rule_definition.time : #{time}
        play_total_time = time_trackers.sum('time', :conditions => ["created_at >= ?", Time.now.beginning_of_day])
        total_time - play_total_time + bonus_time
      end
    EOS
  end

  def bonus_time
    @bonus_time ||= bonus.sum(:time, :conditions => ["created_at >= ?", Date.today.ago(Bonus::EXPIRE_WEEKS.weeks)])
  end


  def age_range
    #get age range
    if self.birthday
     year = Time.now.year - self.birthday.year
     for rating in GameApplication::RATINGS.sort()
       if year < rating
         break
       end
     end
     rating
    end
  end

end
