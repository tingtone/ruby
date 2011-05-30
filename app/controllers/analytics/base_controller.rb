class Analytics::BaseController < ApplicationController 
  include Parent::BaseHelper    
  include Analytics::BaseHelper        

  before_filter :authenticate_parent!
  before_filter :current_parent_game_applications
   
end
