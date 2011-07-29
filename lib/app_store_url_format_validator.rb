class AppStoreUrlFormatValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)  
    begin
      app = Crawler.new value
      if value !~ /itunes.apple.com/i
        object.errors[attribute] << (options[:message] || "URL is not formatted properly!")
      elsif   value !~ /itunes.apple.com\/us/i
        object.errors[attribute] << (options[:message] || "Please only use links to the US App Store!")
      elsif app.page.title == 'Connecting to the iTunes Store.'
        object.errors[attribute] << (options[:message] || "URL is invalid!!")
      end
    rescue
      object.errors[attribute] << (options[:message] || "URL is invalid!!")  
    end
  end  
end