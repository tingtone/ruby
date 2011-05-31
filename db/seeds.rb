Child.destroy_all
ParentClientApplication.destroy_all
Parent.destroy_all
ClientApplicationCategory.destroy_all
Grade.destroy_all
ClientApplication.destroy_all
Developer.destroy_all

developer = Developer.create(:email => 'richard@kittypad.com', :password => 'richard', :password_confirmation => 'richard')

game_application1 = developer.game_applications.create(:name => 'first app', :description => 'first app', :identifier => 'com.apple.identifier1')
game_application2 = developer.game_applications.create(:name => 'second app', :description => 'second app', :identifier => 'com.apple.identifier2')

[[:junior, 0, 999], [:senior, 1000, 9999], [:top, 1000, 999999999]].each do |name, min_score, max_score|
  Grade.create(:name => name, :min_score => min_score, :max_score => max_score)
end

english = ClientApplicationCategory.create(:name => 'English')
chinese = ClientApplicationCategory.create(:name => 'Chinese')
math = ClientApplicationCategory.create(:name => 'Math')
music = ClientApplicationCategory.create(:name => 'Music')
geography = ClientApplicationCategory.create(:name => 'Geography')
history = ClientApplicationCategory.create(:name => 'History')
drawing = ClientApplicationCategory.create(:name => 'Drawing')
mixed = ClientApplicationCategory.create(:name => 'Mixed')

parent = Parent.create(:email => 'parent@kittypad.com', :password => 'parent', :password_confirmation => 'parent')

ParentClientApplication.create(:parent => parent, :client_application => game_application1)
ParentClientApplication.create(:parent => parent, :client_application => game_application2)

child1 = parent.children.create(:fullname => 'Child1', :gender => 'male', :birthday => '2003/11/07')
child2 = parent.children.create(:fullname => 'Child2', :gender => 'female', :birthday => '2006/11/02')

game_application1.time_trackers.create(:child=>child1,:time=>30,:created_at => 2.days.ago)
game_application1.time_trackers.create(:child=>child1,:time=>20,:created_at => 4.days.ago)
game_application1.time_trackers.create(:child=>child1,:time=>50,:created_at => 5.days.ago)

game_application2.time_trackers.create(:child=>child2,:time=>10,:created_at => 1.days.ago)
game_application2.time_trackers.create(:child=>child2,:time=>30,:created_at => 3.days.ago)
game_application2.time_trackers.create(:child=>child2,:time=>40,:created_at => 5.days.ago)

education_application1 = developer.education_applications.create(:name => 'first edu', :description => 'first edu', :client_application_category => math, :identifier => 'com.apple.edu.identifier1')
education_application2 = developer.education_applications.create(:name => 'second edu', :description => 'second edu', :client_application_category => english, :identifier => 'com.apple.edu.identifier2')

ParentClientApplication.create(:parent => parent, :client_application => education_application1)
ParentClientApplication.create(:parent => parent, :client_application => education_application2)
