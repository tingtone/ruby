class Developer < User
  has_many :apps, :foreign_key => :user_id
end