class Message
  include Shared::Mongoid

  #cache

  #fields
  field :subject
  field :body
  field :sender_deleted, :type => Boolean, :default => false
  field :recipient_deleted, :type => Boolean, :default => false
  field :read_at, :type => DateTime

  referenced_in :sender, :class_name => "ForumUser", :null=> true, :foreign_key => "sender_id"
  referenced_in :recipient, :class_name => "ForumUser", :null=> true, :foreign_key => "recipient_id"

  index :sender
  index :reipient

  referenced_in :group_message

  validates_presence_of :subject
  validates_presence_of :body
  validates_presence_of :sender
  validates_presence_of :recipient

  def read?
     self.read_at != nil
  end

  def read
    unless read?
      self.read_at = Time.now
      self.save!
    end
  end

  def delete(user,box="inbox")
    if user == self.recipient and box=="inbox"
      self.recipient_deleted = true
    elsif user == self.sender and box=="outbox"
      self.sender_deleted = true
    end
    self.save!
  end

  class << self

    def inbox(user, params, page_size=10)
      if user
        return Message.where(recipient_id: user.id).and(recipient_deleted: false).desc(:created_at).page(params[:page]||1).per(page_size)
      end
    end

    def outbox(user, params, page_size=10)
      if user
        return Message.where(sender_id: user.id).and(sender_deleted: false).desc(:created_at).page(params[:page]||1).per(page_size)
      end
    end

    def box_count(user, options = {})
      read = options.delete(:read)
      default_options = {'recipient_deleted' => false}
      default_options['sender_id'] = user.id if options[:outbox]
      if options[:box] == 'outbox'
        default_options['sender_id'] = user.id
      else
        default_options['recipient_id'] = user.id
      end
      if read
        default_options['read_at'] = {'$ne' => nil}
      elsif read == false
        default_options['read_at'] = nil
      end
      Message.count(:conditions => default_options)
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
        #Message.where(sender_id: user.id).max(:group_message_id)
        return Message.where(recipient_id: user.id).and({'group_message_id'=> {'$ne'=>nil}}).max("created_at")
      end
    end
  end

end