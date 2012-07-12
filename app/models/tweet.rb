class Tweet < ActiveRecord::Base
  attr_accessible :body, :updated_at
end
