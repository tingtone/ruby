class Dev::SessionsController < Devise::SessionsController
  layout 'dev'

  def after_sign_in_path_for(resource)
    forum_user = ForumUser.first(conditions: {name: current_developer.name})
    sign_in(:forum_user, forum_user)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
