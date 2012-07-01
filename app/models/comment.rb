class Comment < ActiveRecord::Base
  
  belongs_to :post
  
  attr_accessible :name, :email, :body, :website
  
  validates :name, :email, :body, :presence => true
  
end
