class OwnersController < InheritedResources::Base
  before_filter :authenticate_owner!, :only => [:new, :edit, :create, :update]
  
  def index
    if !params[:device].blank?
      @player = Player.find_by_device_identifier(params[:device])
      @owner = @player.owner
      redirect_to statisticses_path(:device => params[:device])
    end
  end #index
end
