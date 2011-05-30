module Parent::BaseHelper
  def current_child
    @child ||= begin
                 session[:child_id] = params[:child_id] if params[:child_id]
                 child = current_parent.children.find_by_id(session[:child_id]) if session[:child_id]
                 unless child
                   child = current_parent.children.first
                   session[:child_id] = child.try(:id)
                 end
                 child
               end
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
