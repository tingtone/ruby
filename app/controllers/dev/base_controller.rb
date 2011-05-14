class Dev::BaseController < ApplicationController
  layout 'dev'

  before_filter :authenticate_developer!
  before_filter :current_game_applications
  before_filter :current_education_applications

  helper_method :current_game_applications
  helper_method :current_education_applications

  protected
    def current_game_applications
      @game_applications ||= current_developer.game_applications.all
    end

    def current_education_applications
      @education_applications ||= current_developer.education_applications.all
    end
end
