class Forum::AppCenterController < Forum::BaseController
  #applications center for filter
  #and recommands applications

  def index
    #for filter apps
    @applications = ClientApplication.find(params)
    #for recommands
    @recommands = ClientApplication.recommands(current_parent)
  end



end