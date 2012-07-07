class Tweet < ActiveRecord::Base
  attr_accessible :body, :last_checked_at
end
