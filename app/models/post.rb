class Post < ActiveRecord::Base
  
  has_many :comments
  attr_accessible :body, :title, :published, :description
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]
  
end
