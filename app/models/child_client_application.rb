class ChildClientApplication < ActiveRecord::Base
  belongs_to :child
  belongs_to :client_application

  def as_json(options={})
    {:client_application => client_application, :time => time}
  end
end
