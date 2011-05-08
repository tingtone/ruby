developer = Developer.create(:email => 'richard@kittypad.com', :password => 'richard', :password_confirmation => 'richard')

developer.client_applications.create(:name => 'first app')
developer.client_applications.create(:name => 'second app')

[[:junior, 0, 999], [:senior, 1000, 9999], [:top, 1000, 999999999]].each do |name, min_score, max_score|
  Grade.create(:name => name, :min_score => min_score, :max_score => max_score)
end
