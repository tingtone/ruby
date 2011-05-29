module Parent::BaseHelper
  def current_child
    session[:child_id] = params[:child_id] if params[:child_id]
    session[:child_id] = current_parent.children.first.id unless session[:child_id]
    @child ||= current_parent.children.find(session[:child_id])
  end

  def other_children
    children = current_parent.children.all
    children.delete(current_child)
    children
  end

  def current_parent_game_applications
    @game_applications ||= current_parent.game_applications.all
  end

  def current_parent_education_applications
    @education_applications ||= current_parent.education_applications.all
  end
end
