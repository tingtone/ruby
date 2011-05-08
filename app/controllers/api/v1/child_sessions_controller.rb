class Api::V1::ChildSessionsController < Api::V1::BaseController
  skip_before_filter :parent_required

  def create
    child = Child.find_by_email(params[:email])
    if child && child.valid_password?(params[:password])
      render :json => {:error => false, :authentication_token => child.authentication_token}
    else
      render :json => {:error => true}
    end
  end
end
