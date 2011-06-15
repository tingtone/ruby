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

  validates_presence_of :subject
  validates_presence_of :body
  validates_presence_of :sender
  validates_presence_of :recipient

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
      if user
        return Message.where(recipient_id: user.id).and(recipient_deleted: false).order(sorted).page(params[:page]||1).per(page_size)
      end
    end

    def outbox(user, params, page_size=20, sorted="created_at desc")
      if user
        ms = Message.where(sender_id: user.id).and(sender_deleted: false).order(sorted).page(params[:page]||1).per(page_size)
        ms
      end
    end

    def drops(user, ids, box="inbox")
      if user
        if box == "inbox"
          Message.all_in(_id: ids).and(recipient_id: user.id).update_all(recipient_deleted: true)
        elsif box == "outbox"
          Message.all_in(_id: ids).and(sender_id: user.id).update_all(sender_deleted: true)
        end
      end
    end

    def last_group_message(user)
      if user
        Message.where(sender_id: user.id).max(:group_message_id)
      end
    end

  end

end