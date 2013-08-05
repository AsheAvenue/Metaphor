class User < ActiveRecord::Base
  rolify
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :last_name, :role_ids
  
  authenticates_with_sorcery!
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :username
  validates_uniqueness_of :username
  
  has_and_belongs_to_many :roles, :join_table => :users_roles
  
  scope :alphabetical, order("users.first_name, users.last_name asc")
  
  def role
    roles.first
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def display_name
    (full_name && full_name.strip != "") ? full_name : username
  end
  
end
