require 'twitter'
require 'yaml'

class Tweet
  $config = YAML.load_file 'config.yml'

  def tweet tweet

    client = Twitter::REST::Client.new do |twitter_config|
      twitter_config.consumer_key        = $config['CONSUMER_KEY']
      twitter_config.consumer_secret     = $config['CONSUMER_SECRET']
      twitter_config.access_token        = $config['OAUTH_TOKEN']
      twitter_config.access_token_secret = $config['OAUTH_TOKEN_SECRET']
    end

    dir = Dir.open($config['TMP_DIR'])

    img_upload_path = nil
    dir.each{|file|
      if file[0] != '.'
        img_upload_path = $config['TMP_DIR'] + file
      end
    }

    if img_upload_path
      image = File.open(img_upload_path)
      client.update_with_media(tweet, image)
    else
      client.update(tweet)
    end
  end # tweet method end
end # class-end
