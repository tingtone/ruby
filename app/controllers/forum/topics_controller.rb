# 
#  topics_controller.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Forum::TopicsController < Forum::BaseController
  before_filter :need_login, :only => [:new, :edit]
  load_and_authorize_resource
  before_filter :find_forum, :only => [:index, :new, :edit, :show]
  
  def index
    @topics = @forum.topics.desc("created_at").page(params[:page]).per(15)
    @sticky_topics = @forum.sticky_topics.first(5)
    @common_topics = (@topics - @sticky_topics)
    @forum.hits_record
  end
  
  def new
    @topic = @forum.topics.new
  end
  
  def edit
    @topic = Topic.find params[:id]
  end
  
  def show
    @topic = Topic.find params[:id]
    @author = ForumUser.find(@topic.forum_user_id)
    @posts = @topic.posts.page(params[:page]).per(14)
    @post = @topic.posts.new
    @topic.hits_record
  end
  
  def create
    @forum = Forum.find params[:topic][:forum_id]
    @topic = @forum.topics.new params[:topic]
    @topic.forum_user_id = current_user.id
    if @topic.save
      flash[:notice] = "Topic Create Successfully."
      redirect_to forum_forum_topics_path(@forum)
    else
      flash[:error] = "Topic Create UnSuccessfully."
      redirect_to forum_forum_topics_path(@forum)
    end
  end
  
  def update
    @forum = Forum.find params[:topic][:forum_id]
    @topic = Topic.find params[:id]
    @topic.forum_user_id = current_user.id
    if @topic.update_attributes params[:topic]
      flash[:notice] = "Topic Update Successfully."
      redirect_to forum_forum_topics_path(@forum)
    else
      flash[:notice] = "Topic Update UnSuccessfully."
      redirect_to forum_forum_topics_path(@forum)
    end
  end
  
  def destroy
    @topic = Topic.find params[:id]
    if @topic.destory
      flash[:notice] = "Delete is Successfully."
      redirect_to forum_forum_topics_path(@forum)
    end
  end
  
  private
    def find_forum
      @forum = Forum.find params[:forum_id]
    end
    
    def need_login
      find_forum
      if current_user.blank?
        flash[:error] = "Please loged in to continue!"
        redirect_to forum_forum_topics_path(@forum)
      end
    end #need_login
end
