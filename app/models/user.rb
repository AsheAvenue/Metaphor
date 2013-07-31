class User < ActiveRecord::Base
  rolify
  attr_accessible :username, :email, :password, :password_confirmation, :display_name, :role_ids
  
  authenticates_with_sorcery!
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :username
  
  has_and_belongs_to_many :roles, :join_table => :users_roles
  
  scope :alphabetical, order("users.display_name asc")
  
  def role
    roles.first
  end
  
  def display_name
    display_name || ''
  end
  
end
