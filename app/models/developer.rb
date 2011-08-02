class Developer < User
  has_many :apps, :foreign_key => :user_id

  def exchange_own?
    self.exchange_app == 1
  end

  def exchange_all?
    self.exchange_app == 0
  end

  class << self

    def got_exchange_apps(developer_id, device)
      begin
        @developer = Developer.find developer_id
        @player = Player.find_by_device_identifier(device)
        @installed_apps = @player.apps
        @developer_apps = @developer.apps.select{|app| app if !app.app_store_url.blank?}

        if @developer.exchange_own?
          final_apps = @developer_apps
        elsif @developer.exchange_all?
          final_apps = App.valid_apps.select{|app| app if app.developer.exchange_all?}
        else
          final_apps = []
        end #if

        if final_apps.blank?
          @apps = []
        else
          if @player.device_user_agent.match(/iPad/)
            @apps = filter_apps(:apps => final_apps, :support_device => 'iPhone', :device_lang => @player.language, :installed_apps => @installed_apps)
          elsif @player.device_user_agent.match(/iPhone/)
            @apps = filter_apps(:apps => final_apps, :support_device => 'iPad', :device_lang => @player.language, :installed_apps => @installed_apps)
          end
        end
      rescue
        @apps = App.valid_apps.sample(10)
      end
      return @apps
    end #self.got_exchange_apps

    def filter_apps(option={})
      #  apps, support_device, device_lang, installed_apps
      device_lang = device_lang_option option[:device_lang]
      device_apps = option[:apps].select{|app| app if app.support_device == option[:support_device] || app.support_device == 'iPad/iPhone'} if !option[:apps].blank?
      language_apps = device_apps.select{|app| app if (app.language.include?(device_lang) ? app.language.include?(device_lang) : app.language == 'English'  ) } if !device_apps.blank?
      final_apps = (language_apps - option[:installed_apps]).sample(10)
      return final_apps
    end #filter_apps(support_device, language)

    def device_lang_option(device_lang)
      case device_lang.to_s
      when 'en'
        'English'
      when 'fr'
        'French'
      when 'de'
        'German'
      when 'es'
        'Spanish'
      when 'pt'
        'Portuguese'
      when 'it'
        'Italian'
      when 'zh'
        'Chinese'
      when 'ja'
        'Japanese'
      when 'ko'
        'Korean'
      when 'ru'
        'Russian'
      end
    end #device_lang_option
  end
end
