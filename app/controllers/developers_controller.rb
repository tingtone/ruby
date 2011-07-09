class DevelopersController < InheritedResources::Base
  before_filter :authenticate_developer!
  
  def index
    
  end #index
end
