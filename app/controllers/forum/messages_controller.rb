class Forum::MessagesController < Forum::BaseController
  before_filter :authenticate_forum_user!, :only => [:create, :update]

  layout "message"

  def index
    if not params["page"]
      current_user.check_group_messages
    end

    if params['box'] == "outbox"
      @messages = Message.outbox(current_user,params)
    else
      @messages = Message.inbox(current_user,params)
    end

  end

  def new
    #
  end


  def show
    @message = Message.first(conditions: {_id: params["id"]})
  end

  def create
    @recipient = ForumUser.first(conditions: {name: params[:message][:recipient]})
    if @recipient
      if params[:group]
        ms = current_user.send_group_message(params[:message][:subject],params[:message][:body])
      else
        ms = current_user.send_message(@recipient,params[:message][:subject],params[:message][:body])
      end
      if ms
        flash[:notice] = "Topic Create Successfully."
        redirect_to forum_messages_path
      else
        flash[:error] = "Topic Create UnSuccessfully."
        redirect_to new_forum_message_path
      end
    else
      flash[:error] = "Topic Create UnSuccessfully.Recipent not exist!"
      redirect_to new_forum_message_path
    end
  end

end