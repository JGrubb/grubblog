class Tweet
  
  include MongoMapper::Document
  attr_accessible :body, :updated_at
end
