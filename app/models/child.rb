class Child < ActiveRecord::Base
  validates_presence_of :fullname, :gender, :birthday
  belongs_to :parent

  def as_json(options={})
    {:id => id, :fullname => fullname}
  end
end
