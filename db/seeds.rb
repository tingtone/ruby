developer = Developer.create(:email => 'richard@kittypad.com', :password => 'richard', :password_confirmation => 'richard')

developer.client_applications.create(:name => 'first app')
developer.client_applications.create(:name => 'second app')
