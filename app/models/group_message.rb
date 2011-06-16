class GroupMessage
  include Shared::Mongoid


  #fields
  field :subject
  field :body

  referenced_in :sender, :class_name => "ForumUser", :null=> true, :foreign_key => "sender_id"
  index :sender

  validates_presence_of :subject
  validates_presence_of :body

  class << self
    def syn_message(user)
      if user
        last_group_created_at = Message.last_group_message(user)
        last_group_created_at = defaut_group if not last_group_created_at

        Rails.logger.add(1, " **************** " )
        Rails.logger.add(1, "group id #{last_group_created_at}")
        #default just recently message 10
        gms = GroupMessage.where({'created_at' => {'$gt' => last_group_created_at}}).order("created_at desc").limit(10)

        gms.each do |group|
          if group.sender
            group.sender.send_message(user, group.subject, group.body,group)
          end
        end

        true
      else
        false #not have new group message
      end
    end

    def defaut_group
      Time.utc(2010, 1, 1)
      #group_id = BSON::ObjectId.from_time(time)
      #group_id
    end
  end

end