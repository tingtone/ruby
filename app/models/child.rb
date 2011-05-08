class Child < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
  before_save :ensure_authentication_token

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  belongs_to :parent
  has_many :achievements
  has_many :child_client_applications

  def as_json(options={})
    {:id => id, :email => email, :achievements => achievements, :applists => child_client_applications}
  end
end
