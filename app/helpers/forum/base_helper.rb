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
  
  def get_menu_class(path)
    style = ""
    style = "cur" if current_page?(path)
    return style
  end #get_menu_class
  
  %w|games news about parent_room support_room |.each do |name|
    define_method "get_#{name}_class" do |controller_name, action_name|
      controller_name = controller_name.split("/").last
      if %w|forums app_centers|.include?(controller_name) && %w|index|.include?(action_name) && name == "games"
        'cur'
      elsif %w|forums|.include?(controller_name) && %w|news|.include?(action_name) && name == "news"
        'cur'
      elsif %w|forums|.include?(controller_name) && %w|about|.include?(action_name) && name == "about"
        'cur'
      elsif %w|forums topics|.include?(controller_name) && %w|index show new edit|.include?(action_name) && name == "parent_room" && !@forum.blank? && @forum.name == "Parent Room"
        'cur'
      elsif %w|forums topics|.include?(controller_name) && %w|index show new edit|.include?(action_name) && name == "support_room" && !@forum.blank? && @forum.name == "Support Room"
        'cur'
      end #name
    end
  end
  
  def get_forum_room_class(controller_name, action_name, of)
    if of.name == "Support Room"
      get_support_room_class(controller_name, action_name)
    elsif of.name == 'Parent Room'
      get_parent_room_class(controller_name, action_name)
    end
  end #get_forum_room_class of
  
  def format_time(timedate)
    timedate.strftime("%y-%m-%d %H:%m %p") unless timedate.blank?
  end #format_time
  
  def last_updated_name(topic)
    user_name = topic.posts.try(:last).try(:forum_user).try(:name)
    if user_name.blank?
      user_name = topic.try(:forum_user).try(:name)
    end
    return user_name
  end #last_updated
  
  def last_updated_time(topic)
    updated_at = topic.posts.try(:last).try(:updated_at)
    if updated_at.blank?
      updated_at = topic.try(:updated_at)
    end
    return updated_at
  end #last_updated_time
  
end
