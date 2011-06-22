# 
#  init_administrator.thor
#  ruby
#  
#  Created by Zhang Alex on 2011-06-22.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 
# when run it in production env , need run: export RAILS_ENV=production
# thor -T


class InitAdministrator < Thor
  include Thor::Actions
  desc "for_forum", "init forum administrator"
  method_options :name => :string, :email => :string, :password => :string
  def for_forum
    require './config/environment'
    begin
      name     = options[:name].blank? ? 'Administrator' : options[:name]
      email    = options[:email].blank? ? 'zhao@kittypad.com' : options[:email]
      password = options[:password].blank? ? 'kittypadadmin321' : options[:password]

      fu = ForumUser.new(name: name, email: email, password: password)
      fu.save
      fu.roles << Role.admin

      say "#{fu.name} be create successfully.", :green
    rescue
      say "something is wrong!", :red
    end


  end
end
