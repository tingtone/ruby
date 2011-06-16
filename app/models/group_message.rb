class GroupMessage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia


  #fields
  field :subject
  field :body

  referenced_in :sender, :class_name => "ForumUser", :null=> true, :foreign_key => "sender_id"

  validates_presence_of :subject
  validates_presence_of :body

  class << self
    def syn_message(user)
      if user
        group_id = Message.last_group_message(user)
        group_id = defaut_group if not group_id

        #default just recently message 10
        gms = GroupMessage.where({'_id' => {'$gt' => group_id}}).order("created_at desc").limit(10)

        gms.each do |group|
          if group.sender
            group.sender.send_message(user, group.subject, group.body,group)
          end
        end

        if gms.length > 0
          Notifier.new_group_message(user,gms).deliver
        end

        true
      else
        false #not have new group message
      end
    end

    def defaut_group
      time = Time.utc(2010, 1, 1)
      group_id = BSON::ObjectId.from_time(time)
      group_id
    end
  end

end