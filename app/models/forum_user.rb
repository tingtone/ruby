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
  field :posts_count, :type => Integer, :default => 0
  
  # field :roles_mask, :type => Fixnum, :default => 0
  
  references_many :topics
  
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
  # ROLES = [:guest, :developer, :admin]
  #   
  #   scope :with_role, lambda { |role| { :where => {:roles_mask.gte => ROLES.index(role) } } }
  #   
  #   def admin?
  #     ForumUser.all.any? ? (self == ForumUser.first || role?(:admin)) : true
  #   end
  # 
  #   def role=(role)
  #     self.roles_mask = ROLES.index(role)
  #     Rails.logger.warn("SET ROLES TO #{self.roles_mask} FOR #{self.inspect}")
  #   end
  # 
  #   # return user's role as symbol.
  #   def role
  #     ROLES[roles_mask].to_sym
  #   end
  # 
  #   # Ask if the user has at least a specific role.
  #   #   @user.role?('admin')
  #   def role?(role)
  #     self.roles_mask >= ROLES.index(role.to_sym)
  #   end
  
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
    ms.subject = subject
    ms.body = body
    ms.group_message_id = group.id if group
    self.messages << ms
    ms.save!
    ms
  end

  def send_group_message(subject,body)
    gms = GroupMessage.new(subject: subject,body: body)
    gms.sender = self
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