#
# init_forum.thor
# ruby
# 
# Created by Zhang Alex on 2011-06-20.
# Copyright 2011 __KittyPad.com__. All rights reserved.
#
# when run it in production env , need run: export RAILS_ENV=production
# thor -T
# thor init_forum:parent_room_and_support_room -n "Support Room" -d "Talk about something" -p 1

class InitForum < Thor
  include Thor::Actions
  desc "parent_room_and_support_room", "init forum boards, you need -n, -d, -p"
  method_options :n => :string, :d => :string, :p => 0
  def parent_room_and_support_room
    require './config/environment'
    begin
      name    = options[:n].blank? ? 'Parent Room' : options[:n]
      desc    = options[:d].blank? ? '' : options[:d]
      position = options[:p]

      forum = Forum.new(name: name, description: desc, position: position)
      forum.save

      say "#{forum.name} be create successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end
  
  desc "delete_all_forums", "destroy all forums include topics, you need --f"
  method_options :f => true
  def delete_all_forums
    require './config/environment'
    if options[:f]
      if yes?("Are u sure delete all forums ? (yes | no)", :red)
        forums = Forum.all
        forums.each do |fu|
          fu.destroy!
        end
        say "#{forums.size} forums be deleted!", :red
      else
        say 'nothing', :red
        return
      end
    end
  end #delete_all_forums

  
end #InitForum