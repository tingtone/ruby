class AppsController < InheritedResources::Base
  before_filter :authenticate_developer!, :only => [:new, :edit, :create, :update]
  
end
