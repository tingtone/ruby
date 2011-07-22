class Pad::SessionController < Devise::SessionController

  def after_sign_in_path_for(resource)
    owners_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

end