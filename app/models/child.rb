class Child < ActiveRecord::Base
  validates_presence_of :fullname, :gender, :birthday
  belongs_to :parent
  has_many :time_trackers
  has_many :score_trackers

  def as_json(options={})
    {:id => id, :fullname => fullname, :gender => gender, :birthday => birthday.to_time.to_i}
  end
end
