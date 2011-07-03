RuleDefinition.destroy_all
MostPlayed.destroy_all
MostDownload.destroy_all
AgeGrade.destroy_all
Child.destroy_all
ParentClientApplication.destroy_all
Parent.destroy_all
ClientApplicationCategory.destroy_all
Category.destroy_all
Grade.destroy_all
ClientApplication.destroy_all
Developer.destroy_all
ScoreTracker.destroy_all
Stats::AppStat.destroy_all
Stats::ChildScoreStat.destroy_all
Stats::ChildAppStat.destroy_all
Stats::AppScoreStat.destroy_all
Stats::AppStat.destroy_all

developer = Developer.create(:name => 'Richard', :company_name => 'Kittypad', :email => 'richard@kittypad.com', :password => 'richard', :password_confirmation => 'richard')

game_application1 = developer.game_applications.create(:name => 'faster', :description => 'first app', :identifier => 'com.apple.identifier1')
game_application2 = developer.game_applications.create(:name => 'angry pig', :description => 'second app', :identifier => 'com.apple.identifier2')

[[:level_1, 0, 300], [:level_2, 301, 800], [:level_3, 801, 1500], [:level_4, 1501, 2500], [:level_5, 2501, 4000], [:level_6, 4001, 60000], [:level_7, 8001, 10000]].each_with_index do |grade, index|
  name, min_score, max_score = *grade
  Grade.create(:name => name, :min_score => min_score, :max_score => max_score, :number => index + 1)
end

english = Category.create(:name => 'English')
chinese = Category.create(:name => 'Chinese')
math = Category.create(:name => 'Math')
music = Category.create(:name => 'Music')
geography = Category.create(:name => 'Geography')
history = Category.create(:name => 'History')
drawing = Category.create(:name => 'Drawing')
mixed = Category.create(:name => 'Mixed')

parent = Parent.create(:email => 'parent@kittypad.com', :password => 'parent', :password_confirmation => 'parent')

ParentClientApplication.create(:parent => parent, :client_application => game_application1)
ParentClientApplication.create(:parent => parent, :client_application => game_application2)

child1 = parent.children.create(:fullname => 'Child1', :gender => 'boy', :birthday => 1068134400)
child2 = parent.children.create(:fullname => 'Child2', :gender => 'girl', :birthday => 1162396800)

game_application1.time_trackers.create(:child=>child1, :time=>30, :created_at => 2.days.ago)
game_application1.time_trackers.create(:child=>child1, :time=>20, :created_at => 4.days.ago)
game_application1.time_trackers.create(:child=>child1, :time=>50, :created_at => 5.days.ago)

game_application2.time_trackers.create(:child=>child2, :time=>10, :created_at => 1.days.ago)
game_application2.time_trackers.create(:child=>child2, :time=>30, :created_at => 3.days.ago)
game_application2.time_trackers.create(:child=>child2, :time=>40, :created_at => 5.days.ago)

education_application1 = developer.education_applications.create(:name => 'ninja math', :description => 'ninja math', :identifier => 'com.apple.edu.identifier1')
education_application1.client_application_categories.create(:category => math)
education_application2 = developer.education_applications.create(:name => 'letter on', :description => 'letter on', :identifier => 'com.apple.edu.identifier2')
education_application2.client_application_categories.create(:category => english)

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

#以下是统计模拟数据
#通过总结统计信息分为两大类，两大类中又分为两小类
#1.应用程序统计 ：分为 score 和 使用 time 统计
#2.孩子的应用程序统计：分为score 和 使用 time 统计

#App
Stats::AppStat.log(child1, game_application1, 10)
Stats::AppStat.log(child1, game_application2, 8)
Stats::AppStat.log(child1, education_application1, 10)
Stats::AppStat.log(child1, education_application2, 8)

Stats::AppStat.log(child2, game_application1, 12)
Stats::AppStat.log(child2, game_application2, 7)
Stats::AppStat.log(child2, education_application1, 12)
Stats::AppStat.log(child2, education_application2, 7)


Stats::AppScoreStat.log(child1, game_application1, 20)
Stats::AppScoreStat.log(child1, game_application2, 13)
Stats::AppScoreStat.log(child1, education_application1, 11)
Stats::AppScoreStat.log(child1, education_application2, 8)

Stats::AppScoreStat.log(child2, game_application1, 18)
Stats::AppScoreStat.log(child2, game_application2, 13)
Stats::AppScoreStat.log(child2, education_application1, 32)
Stats::AppScoreStat.log(child2, education_application2, 6)

#Child
Stats::ChildAppStat.log(child1, game_application1, 19)
Stats::ChildAppStat.log(child1, game_application2, 8)
Stats::ChildAppStat.log(child1, education_application1, 11)
Stats::ChildAppStat.log(child1, education_application2, 10)

Stats::ChildAppStat.log(child2, game_application1, 12)
Stats::ChildAppStat.log(child2, game_application2, 7)
Stats::ChildAppStat.log(child2, education_application1, 22)
Stats::ChildAppStat.log(child2, education_application2, 17)


Stats::ChildScoreStat.log(child1, game_application1, 20)
Stats::ChildScoreStat.log(child1, game_application2, 13)
Stats::ChildScoreStat.log(child1, education_application1, 11)
Stats::ChildScoreStat.log(child1, education_application2, 8)

Stats::ChildScoreStat.log(child2, game_application1, 22)
Stats::ChildScoreStat.log(child2, game_application2, 17)
Stats::ChildScoreStat.log(child2, education_application1, 12)
Stats::ChildScoreStat.log(child2, education_application2, 7)

50.times do |i|
  Stats::AppScoreStat.log(child1, game_application1, rand(i) )
  Stats::AppScoreStat.log(child1, game_application2, rand(i))
  Stats::AppScoreStat.log(child1, education_application1, rand(i))
  Stats::AppScoreStat.log(child1, education_application2, rand(i))

  Stats::AppScoreStat.log(child2, game_application1, rand(i) )
  Stats::AppScoreStat.log(child2, game_application2, rand(i))
  Stats::AppScoreStat.log(child2, education_application1, rand(i))
  Stats::AppScoreStat.log(child2, education_application2, rand(i))
end





