class Dev::EducationApplicationsController < Dev::BaseController
  inherit_resources

  def create
    create! do |success, failure|
      success.html {
        redirect_to :action => :edit, :id => @education_application
      }
    end
  end

  def update
    update! do |success, failure|
      success.html {
        redirect_to :action => :edit, :id => @education_application
      }
    end
  end

  protected
    def begin_of_association_chain
      current_developer
    end
end
