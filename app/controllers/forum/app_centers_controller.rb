class Forum::AppCentersController < Forum::BaseController
  #applications center for filter
  #and recommands applications

  def current_parent_include_child
    @current_parent = Parent.includes(:children).limit(1)
    @current_parent
  end


  def index
    #for filter apps
    @apps = ClientApplication.filters(params)
    #for recommands
    @recommands = ClientApplication.recommands(current_parent)

    render :template => 'forum/app_centers/index'
  end





end