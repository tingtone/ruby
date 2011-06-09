class Forum::BaseController < ApplicationController
  include Parent::BaseHelper

  layout 'forum'

  before_filter :authenticate_parent!
end
