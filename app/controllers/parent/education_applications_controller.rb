class Parent::EducationApplicationsController < Parent::BaseController
  inherit_resources

  def show
    @education_application = EducationApplication.find(params[:id])
  end
end
