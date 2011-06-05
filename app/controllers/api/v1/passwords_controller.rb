class Api::V1::PasswordsController < Api::V1::BaseController
  before_filter :parent_required

  def create
    result = current_parent.send_reset_password_instructions

    if result.errors.empty?
      render :json => {:error => false}
    else
      render :json => {:error => true}
    end
  end
end
