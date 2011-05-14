ParentClientApplication.destroy_all
Parent.destroy_all
ClientApplicationCategory.destroy_all
Grade.destroy_all
ClientApplication.destroy_all
Developer.destroy_all

developer = Developer.create(:email => 'richard@kittypad.com', :password => 'richard', :password_confirmation => 'richard')

game_application1 = developer.game_applications.create(:name => 'first app', :description => 'first app', :identifier => 'com.applie.identifier1')
game_application2 = developer.game_applications.create(:name => 'second app', :description => 'last app', :identifier => 'com.applie.identifier1')

[[:junior, 0, 999], [:senior, 1000, 9999], [:top, 1000, 999999999]].each do |name, min_score, max_score|
  Grade.create(:name => name, :min_score => min_score, :max_score => max_score)
end

[:math, :chinese, :english].each do |name|
  ClientApplicationCategory.create(:name => name)
end

parent = Parent.create(:email => 'parent@kittypad.com', :password => 'parent', :password_confirmation => 'parent')

ParentClientApplication.create(:parent => parent, :client_application => game_application1)
ParentClientApplication.create(:parent => parent, :client_application => game_application2)
