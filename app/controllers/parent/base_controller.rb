class Parent::BaseController < ApplicationController
  include Dev::BaseHelper

  layout 'parent'

  before_filter :authenticate_parent!
  before_filter :current_game_applications
end
