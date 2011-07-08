# 
#  statistics.thor
#  ruby
#  
#  Created by zhang alex on 2011-07-08.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 
# 
#  init_administrator.thor
#  ruby
#  
#  Created by Zhang Alex on 2011-06-22.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 
# when run it in production env , need run: export RAILS_ENV=production
# thor -T


class Statistics < Thor
  include Thor::Actions

  desc "most_active", "init most active everyday"
  # method_options :force => true
  def most_active
    require './config/environment'
    begin
      
      result = TimeTracker.where("DATE_FORMAT(updated_at, '%Y-%m-%d') = ?", (Date.today - 1).to_s(:db)).group(:app_id).sum(:time)
      result.each do |k, v|
        MostActive.create(app_id: k, time: v)
      end

      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end
  
  desc "most_score", 'init most score everyday'
  def most_score
    require './config/environment'
    begin

      say "successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end #most_score

end
