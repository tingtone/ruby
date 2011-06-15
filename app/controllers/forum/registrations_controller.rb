class Forum::RegistrationsController < Devise::RegistrationsController
  layout 'forum'

  def after_sign_up_path_for(resource)
     forum_root_path
   end

   def after_update_path_for(resource)
     forum_root_path
   end

   def after_sign_up_path_for(resource)
     new_forum_user_session_path
   end
end
