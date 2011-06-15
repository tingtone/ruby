class Forum::BlackListsController < Forum::BaseController
  #applications center for filter
  #and recommends applications
  layout "message"

  def index
    @blacklist = FBlackList.list(current_user,params)
  end

  def new
    #
  end

  def create
    @sender = ForumUser.first(conditions: {name: params[:username]})
    if @sender
      if current_user.add_black_list(@sender)
        flash[:notice] = "Topic Create Successfully."
        redirect_to "/forum/messages"
      else
        flash[:error] = "Topic Create UnSuccessfully."
        redirect_to "/forum/messages/new"
      end
    else
      flash[:error] = "Topic Create UnSuccessfully.Recipent not exist!"
      redirect_to "/forum/messages/new"
    end
  end

end