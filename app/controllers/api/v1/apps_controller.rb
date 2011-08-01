class Api::V1::AppsController < Api::BaseController
  #没有用到的api
  def index
    # developer = current_app.developer
    #     if developer.no_exchange?
    #       render :json => {:error => false}
    #     elsif developer.exchange_own?
    #       render :json => {:error => false, :apps => developer.apps.except(current_app.id).collect(&:to_exchange)}
    #     else
    #       render :json => {:error => false, :apps => App.except(current_app.id).random(10).collect(&:to_exchange)}
    #     end
  end
end
