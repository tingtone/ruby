class Parent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :children
  has_many :parent_client_applications
  has_many :client_applications, :through => :parent_client_applications, :source => :client_application
  has_many :rule_definitions

  before_save :ensure_authentication_token

  def add_client_application(client_application)
    unless self.client_applications.include? client_application
      self.parent_client_applications.create(:client_application => client_application)
    end
  end
end
