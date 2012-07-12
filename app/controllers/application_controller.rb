class ApplicationController < ActionController::Base
  require 'yaml'
  require 'json'
  require 'net/http'
  
  protect_from_forgery
  before_filter :get_tweets
  after_filter :check_twitter
  
  def get_tweets
    @raw_tweets = Tweet.last
    # saving JSON to a database turns it in YAML.  Is that just a Rails thing?
    @tweets = YAML.load(@raw_tweets.body)
  end
  
  protected
  
  def check_twitter
    # a Tweet is actually 3 tweets
    tweet = Tweet.last
    # don't check more than evey 5 minutes
    if (tweet.updated_at < 5.minutes.ago)
      # grab last 3 tweets from API
      t = Net::HTTP.get_response("api.twitter.com", "/1/statuses/user_timeline.json?screen_name=johnnygrubb&count=3")
      nt = JSON.parse(t.body)
      json = YAML.load(tweet.body)
      # compare the ids of the most recent tweets from API call and DB
      if nt[0]["id"] == json[0]["id"]
        # if they match, no new tweets. update updated_at.
        tweet.update_attributes(:updated_at => Time.now)
      else 
        # if they don't, save the last 3 tweets.
        new_tweet = Tweet.new
        new_tweet.body = nt
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
