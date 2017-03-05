require 'twitter'
require 'tweetstream'
# gem install twitter tweetstream

require 'yaml'

$config = YAML.load(File.read "../private/config.yaml")

TweetStream.configure do |config|
	config.auth_method        = :oauth
	config.consumer_key       = $config["consumer_key"]
	config.consumer_secret    = $config["consumer_secret"]
	config.oauth_token        = $config["access_token"]
	config.oauth_token_secret = $config["access_token_secret"]
end

t = Twitter::REST::Client.new do |c|
	c.consumer_key        = $config["consumer_key"]
	c.consumer_secret     = $config["consumer_secret"]
	c.access_token        = $config["access_token"]
	c.access_token_secret = $config["access_token_secret"]
end

c = TweetStream::Client.new

c.userstream do |status|
	if status.user.screen_name.downcase == "fluffysesshoowo"
		puts "#{Time.now} :: You tweeted: #{status.text.inspect}"
		puts "#{Time.now} :: Your tweet count: #{status.user.statuses_count}"
	end
end