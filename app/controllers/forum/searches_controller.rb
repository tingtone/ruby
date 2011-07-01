# 
#  searches_controller.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class Forum::SearchesController < Forum::BaseController
  before_filter :need_login, :only => [:index, :create]
  load_and_authorize_resource
  
  def index
    keywords = params[:keywords]
    typee = params[:typee]
    sr = Forum.search(keywords, typee)
    @search_results = Kaminari.paginate_array(sr.flatten.uniq).page params[:page] unless sr.blank?
  end
  
  def create
    @search = Search.create params[:search]
    redirect_to forum_searches_path(:keywords => params[:search][:keywords], :typee => params[:search][:typee])
  end
  
  private
    def need_login
      if current_user.blank?
        flash[:error] = "Please loged in to continue!"
        redirect_to root_path
      end
    end #need_login
end