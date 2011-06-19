# 
#  base_helper.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


module Forum::BaseHelper
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        guser = ForumUser.find(session[:guest_user_id])
        guser.destroy!
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session, 
  # creating one as needed
  def guest_user
    guest_user_num = rand(9999)
    guest_user_id = session[:guest_user_id] ||= ForumUser.create(name: "guest#{guest_user_num}", email: "guest#{guest_user_num}@email.com", password: '123456').id
    @guest_user = ForumUser.find(guest_user_id)
  end
  
  def current_user
    current_forum_user if forum_user_signed_in?
  end
end
