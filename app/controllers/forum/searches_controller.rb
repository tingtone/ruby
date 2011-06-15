class Forum::SearchesController < Forum::BaseController
  
  def index
    keywords = params[:keywords]
    typee = params[:typee]
    sr = Forum.search(keywords, typee)
    @search_results = Kaminari.paginate_array(sr.flatten!).page params[:page] unless sr.blank?
  end
  
  def create
    @search = Search.create params[:search]
    redirect_to forum_searches_path(:keywords => params[:search][:keywords], :typee => params[:search][:typee])
  end
  
end