class Owner < User
  has_many :players, :foreign_key => :user_id
end