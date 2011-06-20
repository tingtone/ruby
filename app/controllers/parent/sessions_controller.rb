class Parent::SessionsController < Devise::SessionsController
  layout 'parent'

  def after_sign_in_path_for(resource)
    parent_root_path
  end

  def after_sign_out_path_for(resource)
    new_parent_session_path
  end

end
