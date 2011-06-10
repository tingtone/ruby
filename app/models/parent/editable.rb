module Parent::Editable
  def editable_by?(parent, is_moderator = nil)
    is_moderator = user.moderator_of?(forum) if is_moderator.nil?
    parent && (parent.id == parent_id || is_moderator)
  end
end