# 
#  forum_user.rb
#  ruby
#  
#  Created by Zhang Alex on 2011-06-17.
#  Copyright 2011 __KittyPad.com__. All rights reserved.
# 


class ForumUser
  include Shared::Mongoid
  
  cache
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  #fields
  field :name
  field :from_pd,    :type => Boolean, :default => false
  field :ban,        :type => Boolean, :default => false
  field :country_id
  field :state_id
  field :city_id
  field :topics_count, :type => Integer, :default => 0
  field :posts_count, :type => Integer, :default => 0
  
  # field :roles_mask, :type => Fixnum, :default => 0
  
  references_many :topics
  references_many :posts
  
  references_and_referenced_in_many :roles
  
  # Setting Moderator for Forum
  references_and_referenced_in_many :forums
  
  # forum user can monitor topics
  references_and_referenced_in_many :topics
  
  references_many :messages
  references_many :group_messages
  references_many :black_lists
  
  validates_presence_of   :name
  validates_presence_of   :email
  validates_uniqueness_of :name,  :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false
  
  attr_accessible :name, :email, :password, :password_confirmation, 
                   :remember_me, :authentication_token, :confirmation_token
  
  #------------------------------------------roles
  
  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
  
  #------------------------------------topics
  def topics
    Topic.where(forum_user_id: self.id)
  end
  
  
  #------------------------------------messages
  # check group messages when login
  def check_group_messages
    GroupMessage.syn_message(self)
  end

  def send_message(reciever,subject,body,group=nil)
    if reciever.black?(self) and not group
      return false,"you are in blacklist"
    end
    ms = Message.new
    ms.recipient = reciever
    ms.sender = self
    ms.subject = subject
    ms.body = body
    ms.created_at = Time.now
    ms.group_message_id = group.id if group
    Rails.logger.add(1,group.id) if group
    Rails.logger.add(1,group.created_at.to_s(:db)) if group
    ms.save!
    self.messages << ms

    #group read on open mail so not  send group message
    Notifier.new_message(self,"http://localhost/",ms).deliver unless group
    ms
  end

  def send_group_message(subject,body)
    gms = GroupMessage.new(subject: subject,body: body)
    gms.sender = self
    gms.created_at = Time.now
    gms.save!
    gms
  end

  def add_black_list(user)
    if not self.black?(user)
      bl = FBlackList.new(user: self,black: user)
      return bl.save!
    else
      return false,"user have added in black_list"
    end
  end

  def black?(user)
    #exits has problem
    FBlackList.count(conditions: {user_id: self.id,black_id: user.id}) > 0
  end

end