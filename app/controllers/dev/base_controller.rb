class Dev::BaseController < ApplicationController
  layout 'dev'

  before_filter :authenticate_developer!
end
