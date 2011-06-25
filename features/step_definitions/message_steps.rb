Given /^(.+) send me a message$/ do |user_name|
  user = ForumUser.first(conditions: {name: user_name})
  user.send_message(@current_user, "Hello", "Welcome to kittypad")
end

When /^(?:|I )write a message with "([^"]*)\/([^"]*)\/([^"]*)"/ do |recipient, subject, body|
  fill_in("message_recipient", :with => recipient)
  fill_in("message_subject", :with => subject)
  fill_in("message_body", :with => body)
  click_button("Send")
end