class Player < User
  has_many :devices
  has_many :accounts
end
