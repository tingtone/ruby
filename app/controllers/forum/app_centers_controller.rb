class Forum::AppCentersController < Forum::BaseController
  #applications center for filter
  #and recommends applications

  def index
    #for filter apps
    @apps = ClientApplication.filters(params)
    #for recommend
    @recommends = ClientApplication.recommends(current_parent)
  end

  def click
    #click app game
    if params[:id]
      @app = ClientApplication.find(params[:id])
      @app.click
    end
    render :text => "true"
  end

end