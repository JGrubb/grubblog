class Post
  
  include MongoMapper::Document
  
  #many :comments
  
  key :body, String, required: true
  key :title, String, required: true
  key :published, Boolean, default: false
  key :slug, String
  
  timestamps!
  
  attr_accessible :body, :title, :published, :description
  
end
