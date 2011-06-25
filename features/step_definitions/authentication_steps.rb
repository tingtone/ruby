Given /^(?:|I )sign up with "([^"]*)\/([^"]*)\/([^"]*)\/([^"]*)"$/ do |name, email, password, password_confirmation|
  #since I dont know login process, just create a user record. This process will be replaced with real login process
  ForumUser.create(:name => name, :email => email, :password => password, :password_confirmation => password_confirmation)
end

Given /^I sign in with "([^"]*)\/([^"]*)"$/ do |email, password|
  Given %Q{I am on the home page}
  fill_in("forum_user_email", :with => email)
  fill_in("forum_user_password", :with => password)
  click_button("login")
  Then %Q{I should be on the home page}
  #I forgot how to get current_user in cucumber, this will be modified
  @current_user = ForumUser.first(conditions: {email: email})
end

Given /^I sign out$/ do

end