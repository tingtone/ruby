class Forum::PostsController < Forum::BaseController
  # load_and_authorize_resource
  before_filter :find_forum_and_topic, :only => [:create, :update, :reply]
  
  def create
    @post = Post.new params[:post]
    @post.forum_user_id = current_user.id
    @post.forum_id = @forum.id
    if @post.save
      flash[:notice] = "Reply Successfully."
      redirect_to forum_forum_topic_path(@forum, @topic)
    else
      flash[:error] = "Reply UnSuccessfully."
      redirect_to forum_forum_topic_path(@forum, @topic)
    end
  end
  
  def update
    @post = Post.find params[:id]
    if @post.update_attributes params[:post]
      @post.update_attributes(:forum_user_id => current_user.id, :forum_id => @forum.id)
      flash[:notice] = "Reply Update Successfully."
      redirect_to forum_forum_topic_path(@forum, @topic)
    else
      flash[:error] = "Reply Update UnSuccessfully."
      redirect_to forum_forum_topic_path(@forum, @topic)
    end
  end
  
  def reply
    @post = Post.find params[:id]
    @reply_post = @topic.posts.new params[:post]
    @reply_post.forum_user_id = current_user.id
    @reply_post.forum_id = @forum.id
    if @reply_post.save
      @post.children << @reply_post
      flash[:notice] = "Reply Successfully."
      redirect_to forum_forum_topic_path(@forum, @topic)
    else
      flash[:error] = "Reply UnSuccessfully."
      redirect_to forum_forum_topic_path(@forum, @topic)
    end
  end
  
  private
    def find_forum_and_topic
      @topic = Topic.find params[:post][:topic_id]
      @forum = @topic.forum
    end
end