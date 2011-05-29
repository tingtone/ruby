class Child < ActiveRecord::Base
  DEFAULT_TOTAL_TIME = 120

  validates_presence_of :fullname, :gender, :birthday
  belongs_to :parent
  has_many :time_trackers
  has_many :score_trackers

  before_create :set_default_total_time

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

  def set_default_total_time
    self.total_time = DEFAULT_TOTAL_TIME
  end
end
