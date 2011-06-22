class Developer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :client_applications
  has_many :game_applications
  has_many :education_applications

  validates_presence_of :name
  validates_uniqueness_of :name
  
  def self.sync_account_to_forum developer_info
    name = developer_info[:name]
    email = developer_info[:email]
    password = developer_info[:password]
    fu = ForumUser.new(name: name, email: email, password: password)
    fu.from_dev = true
    fu.save
    fu.roles << Role.developer
  end #sync_account_to_forum
end
