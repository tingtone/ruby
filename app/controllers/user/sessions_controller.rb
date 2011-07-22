class User::SessionsController < Devise::SessionsController

  def after_sign_in_path_for(resource)
    if current_owner
      owners_path
    elsif current_developer
      developers_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

end