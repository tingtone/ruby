class Forum::BaseController < ApplicationController
  include Forum::BaseHelper
  layout 'forum'

  protected
  
    # == Display a flash if CanCan doesn't allow access
    rescue_from CanCan::AccessDenied do |exception|
      flash[:alert] = "Access denied!"
      redirect_to forum_root_url
    end

    def current_user
      current_forum_user if forum_user_signed_in?
    end

end
