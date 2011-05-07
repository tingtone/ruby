class Device < ActiveRecord::Base
  has_many :client_applications
end
