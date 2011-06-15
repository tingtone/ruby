module Forum::BaseHelper
  def current_user
    current_forum_user if forum_user_signed_in?
  end
end
