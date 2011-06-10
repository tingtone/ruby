class Parent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :total_time

  has_many :children
  has_many :parent_client_applications
  has_many :client_applications, :through => :parent_client_applications, :source => :client_application
  has_many :game_applications, :through => :parent_client_applications, :source => :client_application, :conditions => ["client_applications.type = 'GameApplication'"]
  has_many :education_applications, :through => :parent_client_applications, :source => :client_application, :conditions => ["client_applications.type = 'EducationApplication'"]
  has_many :rule_definitions
  has_many :devices
  has_many :posts, :order => "#{Post.table_name}.created_at desc"
  has_many :topics, :order => "#{Topic.table_name}.created_at desc"


  before_save :ensure_authentication_token


  def add_client_application(client_application)
    unless self.client_applications.include? client_application
      self.parent_client_applications.create(:client_application => client_application)
    end
  end

  def add_device(device_identifier)
    unless self.devices.find_by_identifier(device_identifier)
      self.devices.create(:identifier => device_identifier)
    end
  end

  ######################################
  #        Forum    Utils             #
  #####################################
  def moderator_of?(forum)
    !!(admin? || Moderatorship.exists?(:parent_id => self.id, :forum_id => forum.id))
  end

  def admin?
    false
  end

  def self.prefetch_from(records)
    find(:all, :select => 'distinct *', :conditions => ['id in (?)', records.collect(&:parent_id).uniq])
  end

  def self.index_from(records)
    prefetch_from(records).index_by(&:id)
  end


  def post(forum, attributes)
    attrs = attributes.to_hash.symbolize_keys
    Topic.new(attributes) do |topic|
      topic.forum = forum
      topic.parent  = self
      revise_topic topic, attributes, moderator_of?(forum)
    end
  end

  def reply(topic, body)
    topic.posts.build(:body => body).tap do |post|
      post.forum = topic.forum
      post.parent  = self
      post.save
    end
  end

  def revise(record, attributes)
    is_moderator = moderator_of?(record.forum)
    return unless record.editable_by?(self, is_moderator)
    case record
      when Topic then revise_topic(record, attributes, is_moderator)
      when Post  then post.save
      else raise "Invalid record to revise: #{record.class.name.inspect}"
    end
    record
  end

#  def seen!
#    now = Time.now.utc
#    self.class.update_all ['last_seen_at = ?', now], ['id = ?', id]
#    write_attribute :last_seen_at, now
#  end

  protected
  def revise_topic(topic, attributes, is_moderator)
    topic.title = attributes[:title] if attributes.key?(:title)
    topic.sticky, topic.locked = attributes[:sticky], attributes[:locked] if is_moderator
    topic.save
  end

end
