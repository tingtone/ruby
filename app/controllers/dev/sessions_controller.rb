class Dev::SessionsController < Devise::SessionsController
  layout 'dev'

  def after_sign_in_path_for(resource)
    dev_game_applications_path
  end

  def after_sign_out_path_for(resource)
    new_developer_session_path
  end
end
