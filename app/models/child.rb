class Child < ActiveRecord::Base
  validates_presence_of :fullname, :gender, :birthday
  belongs_to :parent
  has_many :time_trackers
  has_many :client_applications, :through => :child_client_applications, :source => :client_application

  def as_json(options={})
    {:id => id, :fullname => fullname, :gender => gender, :birthday => birthday}
  end
end
