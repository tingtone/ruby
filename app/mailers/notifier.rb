class Notifier < ActionMailer::Base
  default :from => "nonreply@kittypad.com"

  def new_message(recipient, url, message)
    @account = recipient
    @message = message
    @url = url
    mail(:to => recipient.email,:subject=>message.subject)
  end

  def new_group_message(recipient, url, group)
    @account = recipient
    @group = group
    @url = url
    mail(:to => recipient.email,:subject=>@group.subject)
  end

end
