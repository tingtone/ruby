class Forum::BlackListsController < Forum::BaseController
  #applications center for filter
  #and recommends applications
  layout "message"

  def index
    @blacklists = FBlackList.list(current_user,params)
  end

  def new
    #
  end

  def create
    @sender = ForumUser.first(conditions: {name: params[:black_list][:black]})
    if @sender
      success,error = current_user.add_black_list(@sender)
      if success
        flash[:notice] = "Topic Create Successfully."
        redirect_to "/forum/black_lists"
      else
        flash[:error] = "Topic Create UnSuccessfully.#{error}"
        redirect_to "/forum/black_lists/new"
      end
    else
      flash[:error] = "Topic Create UnSuccessfully. black user  not exist!"
      redirect_to "/forum/black_lists/new"
    end
  end

  def destroy
    if params[:id]
      fbl = FBlackList.first(conditions: {_id: params[:id]})
      if fbl.user == current_user
        fbl.destroy! unless fbl.destroyed?
      end
    end
    redirect_to :action=>:index
  end

end