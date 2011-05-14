class Dev::BaseController < ApplicationController
  include Dev::BaseHelper

  layout 'dev'

  before_filter :authenticate_developer!
  before_filter :current_game_applications
  before_filter :current_education_applications
end
