class Parent::BaseController < ApplicationController
  include Parent::BaseHelper

  layout 'parent'

  before_filter :authenticate_parent!
  before_filter :current_parent_game_applications
end
