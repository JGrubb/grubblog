class Post
  
  include MongoMapper::Document
  
  #many :comments
  
  key :body, String, required: true
  key :title, String, required: true
  key :published, Boolean, default: false
  key :slug, String
  key :description, String
  
  timestamps!
  
  attr_accessible :body, :title, :published, :description
  
  def to_param
    "#{self.slug}"
  end
  
end
