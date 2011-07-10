puts "--------> truncate tables"
ActiveRecord::Base.connection.execute("truncate categories;")
ActiveRecord::Base.connection.execute("truncate users;")
ActiveRecord::Base.connection.execute("truncate players;")
ActiveRecord::Base.connection.execute("truncate player_apps;")
ActiveRecord::Base.connection.execute("truncate score_trackers;")
ActiveRecord::Base.connection.execute("truncate time_trackers;")
ActiveRecord::Base.connection.execute("truncate apps;")

# init categories
puts "--------> init categories"
categories = %w|Books Education Game App|
categories.each do |cat|
  Category.create(name: cat)
end

# add sub categories for Education
puts "--------> add sub categories for Education"
education = Category.find_by_name "Education"
education_sub_categories = ['General Knowledge', 'Language', 'Math', 'Puzzles', 'Drawing', 'Stories', 'Music', 'Science', 'Geography', 'History']
education_sub_categories.each do |sub_cate|
  education.children.create(name: sub_cate)
end

# init owner
puts "--------> init owner"
owner = Owner.create(email: 'blackanger.z@gmail.com', password: '123456', name: 'blackanger')

# init player
puts "-------->init player"
player = owner.players.create(name: 'blackanger1', gender: 'man', device_identifier: '318FD1D2-67EF-500E-B564-5089CE2F3B8B', device_user_agent: 'iPad', language: 'en_US')

# init developer
puts "--------> init developer"
developer = Developer.create(name: 'dev1', email: 'dev@kittypad.com', password: '123456', company_name: 'kittypad')

# init app
puts "--------> init app"
app1 = developer.apps.create(name: 'app_test1', description: 'app_description1', price: 10, key: 'app_test1_key', secret: 'app_test1_secret', category_id: 1)
app2 = developer.apps.create(name: 'app_test2', description: 'app_description2', price: 20, key: 'app_test2_key', secret: 'app_test2_secret', category_id: 2)
app3 = developer.apps.create(name: 'app_test3', description: 'app_description3', price: 30, key: 'app_test3_key', secret: 'app_test3_secret', category_id: 3)
app4 = developer.apps.create(name: 'app_test4', description: 'app_description4', price: 40, key: 'app_test4_key', secret: 'app_test4_secret', category_id: 4)

# init active app 
puts "--------> init active app"
player.apps << App.find_by_key('app_test1_key')
player.apps << App.find_by_key('app_test2_key')

#init TimeTracker
puts "--------> init TimeTracker"
tt1 = player.time_trackers.create(time: 60,  app_id: App.find_by_key('app_test1_key').id)
tt2 = player.time_trackers.create(time: 120, app_id: App.find_by_key('app_test2_key').id)
tt3 = player.time_trackers.create(time: 160, app_id: App.find_by_key('app_test3_key').id)
tt4 = player.time_trackers.create(time: 20,  app_id: App.find_by_key('app_test4_key').id)
tt5 = player.time_trackers.create(time: 20,  app_id: App.find_by_key('app_test1_key').id)


puts "--------> Finished Successfully!"
