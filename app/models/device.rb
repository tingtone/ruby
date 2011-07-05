class Device < ActiveRecord::Base
  belongs_to :player
  belongs_to :account
end
