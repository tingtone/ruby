class Parent::EducationApplicationsController < Parent::BaseController
  inherit_resources

  def show
  end

  def index
    if params[:type] == "most_played"
      @most_playeds = MostPlayed.order('time desc').limit(10)
    end
  end
end
