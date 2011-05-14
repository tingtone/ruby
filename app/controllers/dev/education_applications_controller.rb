class Dev::EducationApplicationsController < Dev::BaseController
  inherit_resources

  protected
    def begin_of_association_chain
      current_developer
    end
end
