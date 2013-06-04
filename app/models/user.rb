class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :display_name, :role_ids
  
  authenticates_with_sorcery!
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :username
  
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  
  scope :alphabetical, order("users.display_name asc")
  
  def role
    roles.first
  end
  
end
