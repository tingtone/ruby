class Developer < User
  has_many :apps, :foreign_key => :user_id

  def no_exchange?
    self.exchange_app == 0
  end

  def exchange_own?
    self.exchange_app == 1
  end

  def exchange_all?
    self.exchange_app == 2
  end
end
