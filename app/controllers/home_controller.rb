class HomeController < ApplicationController
  
  def quit
    redirect_to destroy_user_session_path
  end #quit
end