class Forum::BaseController < ApplicationController
  include Forum::BaseHelper
  layout 'forum'
  before_filter :current_or_guest_user


  protected
  
    # == Display a flash if CanCan doesn't allow access
    rescue_from CanCan::AccessDenied do |exception|
      flash[:alert] = "Access denied!"
      redirect_to forum_root_url
    end

    

end
