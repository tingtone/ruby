class Owner < User
  has_many :players, :foreign_key => :user_id

  def as_json(options={})
    {:name => name, :email => email}
  end
end
