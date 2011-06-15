class Forum::ForumsController < Forum::BaseController
  inherit_resources
  # load_and_authorize_resource
  
  def index
    @forums = Forum.ordered_forums
  end
  
  def create
    create!{ forum_forums_path }
  end
  
  def update
    update!{ forum_forums_path }
  end
  
end