class DevelopersController < InheritedResources::Base
  before_filter :authenticate_developer!, :except => [:exchange_app]
  
  def index
    
  end #index
  
  def update
    update!{ developers_path }
  end #update
  
  def exchange_app
    if !params[:device].blank? && !params[:developer_id].blank?
      @apps = Developer.got_exchange_apps(params[:developer_id], params[:device])
    end
  end #exchange_app
end
