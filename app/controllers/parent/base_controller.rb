class Parent::BaseController < ApplicationController
  layout 'parent'

  before_filter :authenticate_parent!
  before_filter :current_game_applications

  helper_method :current_game_applications

  protected
    def current_game_applications
      @game_applications ||= current_parent.game_applications
    end
end
