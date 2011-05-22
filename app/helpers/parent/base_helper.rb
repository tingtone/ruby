module Parent::BaseHelper
  def current_parent_game_applications
    @game_applications ||= current_parent.game_applications.all
  end
end
