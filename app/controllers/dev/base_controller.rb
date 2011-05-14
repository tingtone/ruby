class Dev::BaseController < ApplicationController
  before_filter :authenticate_developer!
end
