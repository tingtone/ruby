class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  #cache

  #fields
  field :subject
  field :body
  field :sender_deleted, :type => Boolean, :default => false
  field :recipient_deleted, :type => Boolean, :default => false
  field :read_at, :type => DateTime

  referenced_in :sender, :class_name => "ForumUser", :null=> true, :foreign_key => "sender_id"
  referenced_in :recipient, :class_name => "ForumUser", :null=> true, :foreign_key => "recipient_id"

  referenced_in :group_message


  def delete(user)
    if user == self.sender
      self.sender_deleted = true
    else
      self.recipient_deleted = true
    end
    self.save!
  end


  class << self

    def inbox(user, params, page_size=20, sorted="created_at desc")
      ms = Message.where(recipient_id: user.id).and(recipient_deleted: false).order(sorted).page(params[:page]||1).per(page_size)
      ms
    end

    def outbox(user, params, page_size=20, sorted="created_at desc")
      ms = Message.where(sender_id: user.id).and(sender_deleted: false).order(sorted).page(params[:page]||1).per(page_size)
      ms
    end

    def drops(user, ids, box="inbox")
      if box == "inbox"
        Message.all_in(_id: ids).and(recipient_id: user.id).update_all(recipient_deleted: true)
      elsif box == "outbox"
        Message.all_in(_id: ids).and(sender_id: user.id).update_all(sender_deleted: true)
      end
    end

    def last_group_message(user)
      Message.where(sender_id: user.id).max(:group_message_id)
    end

  end

end