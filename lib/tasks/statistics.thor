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

  desc "most_active", "init most active top 10"
  
  def most_active
    require './config/environment'
    begin
      

      say "#{fu.name} be create successfully.", :green
    rescue
      say "something is wrong!", :red
    end
  end

end
