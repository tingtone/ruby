class Child < ActiveRecord::Base
  validates_presence_of :fullname, :gender, :birthday
  belongs_to :parent
  has_many :time_trackers
  has_many :score_trackers

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
end
