class User
  
  include ActiveModel::SecurePassword
  include MongoMapper::Document
  
  key :email, String
  key :password, String
  
  timestamps!
  
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation
  
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
end
