class Forum::ForumsController < Forum::BaseController
  # before_filter :admin_required, :except => [:index, :show]
  
  def index 
    @forums = Forum.ordered_forums
  end
  
  def show
    @forum = Forum.find_by_permalink! params[:id]
    @topics = @forum.topics.page params[:page]
  end
  
  def new
    @forum = Forum.new
  end
  
  def edit
    @forum = Forum.find_by_permalink! params[:id]
  end
  
  def create
    @forum = Forum.new params[:forum]
    if @forum.save
      flash[:notice] = "Forum was successfully created."
      redirect_to forum_forums_path
    else
      flash[:error] = "Forum was unsuccessfully created."
      render :action => :new
    end
  end
  
  def update
    @forum = Forum.find_by_permalink! params[:id]
    if @forum.update_attributes params[:forum]
      flash[:notice] = "Forum was successfully updated."
      redirect_to forum_forums_path
    else
      flash[:error] = "Forum was unsuccessfully updated."
      render :action => :new
    end
  end
  
  def destroy
    @forum = Forum.find_by_permalink! params[:id]
    @forum.destroy
    redirect_to forum_forums_path
  end
  
end