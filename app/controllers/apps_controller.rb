class AppsController < InheritedResources::Base
  before_filter :authenticate_developer!, :only => [:new, :edit, :create, :update]
  before_filter :got_developer, :only => [:index, :new, :edit, :create, :update]
  
  def index

    if !params[:developer_id].blank?
      @apps = @developer.apps
    elsif !params[:key].blank? && !params[:device].blank?
      @app = App.find_by_key(params[:key])
      @developer = @app.developer
      redirect_to exchange_app_developer_path(@developer, :device => params[:device], :developer_id => @developer.id)
    else
      developer = Developer.find_by_name('simdm')
      @kittypad_apps = developer.blank? ? [] : developer.apps.each_slice(3).to_a 
      
      # @apps = App.all
    end
  end #index
  
  def new
    @app = @developer.apps.build
  end #new
  
  protected
    def got_developer
      @developer = Developer.find params[:developer_id] if !params[:developer_id].blank?
    end #got_developer
end
