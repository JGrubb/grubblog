class ApplicationController < ActionController::Base
  require 'yaml'
  require 'json'
  protect_from_forgery
  before_filter :get_tweets
  
  def get_tweets
    @raw_tweets = Tweet.order("id DESC").limit(3)
    @tweets = []
    @raw_tweets.each do |tweet|
      t = YAML.load(tweet[:body])
      @tweets.concat(t)
    end
    check_twitter(@raw_tweets.first)
  end
  
  protected
  
  def check_twitter(tweet)
    if (tweet.last_checked_at > 5.minutes.ago)
      t = Net::HTTP.get_response("api.twitter.com", "/1/statuses/user_timeline.json?screen_name=johnnygrubb&count=1")
      t = JSON.parse(t.body)
      json = YAML.load(tweet.body)
      if t[0]["id"] = json["id"]
        tweet.update_attributes(:last_checked_at => Time.now)
      else 
        new_tweet = Tweet.new
        new_tweet.body = t[0]
        new_tweet.last_checked_at = Time.now
        new_tweet.save
      end
    end
  end
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def require_user
    unless logged_in?
      flash[:error] = "Sorry jack.  You gotta be an admin to do that."
      redirect_to root_url
    end
  end
  
  def logged_in?
    !!current_user
  end
  
  helper_method :current_user
  
end
