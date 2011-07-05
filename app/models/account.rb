class Account < ActiveRecord::Base
  belongs_to :player
  has_one :device
end
