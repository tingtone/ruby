class Forum::MessagesController < Forum::BaseController
  #applications center for filter
  #and recommends applications
  layout "message"
  before_filter :require_login_forum

  def index
    @messages = Message.inbox(current_user,params)
  end

  def new
    #
  end


  def show

  end

  def create
    @recipient = ForumUser.first(conditions: {name: params[:recipient]})
    if @recipient
      if current_user.send_message(@recipient,params["subject"],params["body"])
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