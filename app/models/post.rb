class Post < ActiveRecord::Base
  
  attr_accessible :body, :title
  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]
  
end
