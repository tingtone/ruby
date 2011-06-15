class Forum::SearchesController < Forum::BaseController
  
  def index
    keywords = params[:keywords]
    typee = params[:typee]
    @search_resultes = Forum.search(keywords, typee)
  end
  
  def create
    @search = Search.create params[:search]
    redirect_to forum_searches_path(:keywords => params[:search][:keywords], :typee => params[:search][:typee])
  end
  
end