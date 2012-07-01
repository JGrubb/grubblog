class Post < ActiveRecord::Base
  
  has_many :comments
  attr_accessible :body, :title, :published
  extend FriendlyId
  friendly_id :title, :use => [:slugged, :history]
  
end
