class HomeController < ApplicationController
  caches_page :index, :about, :faq, :tos, :copyright, :developer_page
  
  
  def quit
    redirect_to destroy_user_session_path
  end #quit
  
  def download
    sdk_path = "https://s3.amazonaws.com/kittypad_sdk/sdk.zip"
    redirect_to sdk_path
  end #download
end