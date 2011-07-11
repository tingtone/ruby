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
  
  def self.got_exchange_apps(developer_id, device)
    @developer = Developer.find developer_id
    @player = Player.find_by_device_identifier(device)
    @installed_app = @player.apps
    if @developer.exchange_own?
      if @player.device_user_agent.match(/iPad/)
        @apps = (@developer.apps - @install_app).first(7)
      elsif @player.device_user_agent.match(/iPhone/)
        @apps = (@developer.apps - @install_app).first(5)
      end
    elsif @developer.exchange_all?
      if @player.device_user_agent.match(/iPad/)
        @apps = (App.all - @installed_app).sample(7)
      elsif @player.device_user_agent.match(/iPhone/)
        @apps = (App.all - @installed_app).sample(5)
      end
    else
      @apps = []
    end #if
    return @apps
  end #self.got_exchange_apps
end
