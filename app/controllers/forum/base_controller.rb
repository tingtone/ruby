class Forum::BaseController < ApplicationController
  include Parent::BaseHelper
  include ApplicationHelper

  layout 'forum'

  helper_method :current_page
  before_filter :set_language
  before_filter :authenticate_parent!



  def current_page
    @page ||= params[:page].blank? ? 1 : params[:page].to_i
  end

  def set_language
    I18n.locale = :en || I18n.default_locale
  end


end
