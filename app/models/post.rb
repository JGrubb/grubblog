class Post < ActiveRecord::Base
  
  attr_accessible :body, :title, :published
  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]
  
end
