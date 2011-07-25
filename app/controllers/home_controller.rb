class HomeController < ApplicationController
  
  def quit
    redirect_to destroy_user_session_path
  end #quit
  
  def download
    sdk_path = "/sdk/sdk.zip"
    redirect_to sdk_path
  end #download
end