class Forum::BaseController < ApplicationController
  include Parent::BaseHelper
  include ApplicationHelper

  layout 'forum'
  
  # == Display a flash if CanCan doesn't allow access
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied!"
    redirect_to forum_root_url
  end

  def require_login_forum
    if not forum_user_signed_in?
      redirect_to new_forum_user_session_path
    end
  end
 
  def current_user
    current_forum_user if forum_user_signed_in?
  end


end
