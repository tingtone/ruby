module Dev::BaseHelper
  def current_game_applications
    @game_applications ||= current_developer.game_applications.all
  end

  def current_education_applications
    @education_applications ||= current_developer.education_applications.all
  end
end
