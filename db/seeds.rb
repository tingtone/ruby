MostPlayed.destroy_all
MostDownload.destroy_all
AgeGrade.destroy_all
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

[[:level_1, 0, 300], [:level_2, 301, 800], [:level_3, 801, 1500], [:level_4, 1501, 2500], [:level_5, 2501, 4000], [:level_6, 4001, 60000], [:level_7, 8001, 10000]].each_with_index do |grade, index|
  name, min_score, max_score = *grade
  Grade.create(:name => name, :min_score => min_score, :max_score => max_score, :number => index + 1)
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

child1 = parent.children.create(:fullname => 'Child1', :gender => 'male', :birthday => 1068134400)
child2 = parent.children.create(:fullname => 'Child2', :gender => 'female', :birthday => 1162396800)

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

education_application1.time_trackers.create(:child => child1, :time => 30, :created_at => 2.days.ago)
education_application1.time_trackers.create(:child => child1, :time => 20, :created_at => 4.days.ago)
education_application1.time_trackers.create(:child => child1, :time => 50, :created_at => 5.days.ago)

education_application2.time_trackers.create(:child => child2, :time => 10, :created_at => 1.days.ago)
education_application2.time_trackers.create(:child => child2, :time => 30, :created_at => 3.days.ago)
education_application2.time_trackers.create(:child => child2, :time => 40, :created_at => 5.days.ago)

ScoreTracker.create(:child => child1, :client_application => education_application1, :score => 100)
ScoreTracker.create(:child => child2, :client_application => education_application2, :score => 200)
