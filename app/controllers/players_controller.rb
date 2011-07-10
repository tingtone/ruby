class PlayersController < InheritedResources::Base
  before_filter :authenticate_owner!, :only => [:new, :edit, :create, :update]
  before_filter :got_owner, :only => [:index, :edit, :update]
  
  def index
    @players = @owner.players
  end #index
  
  def edit
    @player = Player.find params[:id]
  end #edit
  
  def update
    update!{ owner_players_path(@owner)}
  end #update
  
  protected
    def got_owner
      @owner = Owner.find params[:owner_id]
    end #got_owner
end
