class Notifier < ActionMailer::Base
  default :from => "noreply@kittypad.com"
  smtp_settings :address=> "noreply@kittypad.com", :user_name=>"noreply@kittypad.com", \
      :password=>"abc"

  def new_message(recipient, url, messages)
    @account = recipient
    @messages = messages
    @url = url
    mail(:to => recipient.email)
  end

  def new_group_message(recipient, url, groups)
    @account = recipient
    @groups = groups
    @url = url
    mail(:to => recipient.email)
  end


end
