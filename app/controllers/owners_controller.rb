class OwnersController < InheritedResources::Base
  before_filter :authenticate_owner!
  
  def index
    
  end #index
end
