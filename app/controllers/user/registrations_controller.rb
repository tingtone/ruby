class User::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    developers_path
  end

  def after_update_path_for(resource)
    developers_path
  end

end