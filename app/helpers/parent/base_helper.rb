module Parent::BaseHelper
  def current_child
    @child ||= params[:child_id] ? current_parent.children.find(params[:child_id]) : current_parent.children.first
  end

  def other_children
    children = current_parent.children.all
    children.delete(current_child)
    children
  end

  def current_parent_game_applications
    @game_applications ||= current_parent.game_applications.all
  end
end
