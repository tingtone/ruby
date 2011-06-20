require 'hmac-sha1'

class Parent < ActiveRecord::Base
  include OAuth::Helper

  CLIENT_SALT = 'kittypadsalt.com'

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :total_time, :name

  has_many :children
  has_many :parent_client_applications
  has_many :client_applications, :through => :parent_client_applications, :source => :client_application
  has_many :game_applications, :through => :parent_client_applications, :source => :client_application, :conditions => ["client_applications.type = 'GameApplication'"]
  has_many :education_applications, :through => :parent_client_applications, :source => :client_application, :conditions => ["client_applications.type = 'EducationApplication'"]
  has_many :rule_definitions
  has_many :devices



  before_save :ensure_authentication_token
  before_save :set_client_encrypted_password


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

  def set_name
    self.update_attributes(name: email.split('@').first)
  end #set_name

  def sync_to_forum_user parent_info
    password = parent_info[:password]
    name = email.split('@').first
    fu = ForumUser.new(name: name, email: email, password: password)
    fu.from_pad = true
    fu.save
  end #sync_to_forum_user

  protected
    def set_client_encrypted_password
      if self.password
        self.client_encrypted_password = Base64.encode64(HMAC::SHA1.digest(CLIENT_SALT, self.password)).chomp.gsub(/\n/,'').gsub('+', ' ')
      end
    end
end
