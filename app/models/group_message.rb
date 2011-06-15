class GroupMessage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia


  #fields
  field :subject
  field :body

  referenced_in :sender, :class_name => "ForumUser", :null=> true, :foreign_key => "sender_id"

  class << self
    def syn_message(user)
      if user
        group_id = Message.last_group_message(user)
        puts "group_id" , group_id
        group_id = defaut_group if not group_id

        #default just recently message 10
        gms = GroupMessage.where({'_id' => {'$gt' => group_id}}).order("created_at desc").limit(10)
        puts "gms.length",gms.length
        gms.each do |group|
          group.sender.send_message(user, group.subject, group.body,group)
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