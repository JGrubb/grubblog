class Comment
  include MongoMapper::EmbeddedDocument
  
  embedded_in :post
  
  key :name, String, required: true
  key :comment, String, required: true
  key :email, String, required: true
  key :website, String
  
  #validates :email, format: 
  
  attr_accessible :name, :comment, :email, :website
  
end