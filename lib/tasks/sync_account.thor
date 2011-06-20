#
# sync_account.thor
# ruby
# 
# Created by Zhang Alex on 2011-06-20.
# Copyright 2011 __KittyPad.com__. All rights reserved.
#
# when run it in production env , need run: export RAILS_ENV=production


class SyncAccount < Thor
  include Thor::Actions
  desc "from_forum_to_pd", "sync account between PD and DD"
  method_options :name => :string
  def from_forum_to_pd
    require './config/environment'
    if options[:name]
      account = ForumUser.first(conditions: {name: options[:name]})
      if account
        say "account be found, sync start ...", :green
        @parent = Parent.new(:name => account.name, :encrypted_password => account.encrypted_password, :email => account.email)
        @parent.save(false)
      else
        say "account not be found, sync stop.", :red
      end
    else
      say "pleash pass --name xxx", :red
      return
    end
    
  end #sync_accounts_from_forum_to_pd
  
  
end #SyncAccount