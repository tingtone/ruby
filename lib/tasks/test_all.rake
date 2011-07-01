namespace :test do

  desc "Run all tests"
  #task :all will be appended other test , like rspec , selenium
  task :all =>[:cucumber]

  desc "Run Cucumber tests"
  task :cucumber do
    sh "cucumber"
  end

end

desc "Alias for test:all.. Runs all tests"
task :test => ["test:all"]
