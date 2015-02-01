require 'open-uri'
require 'yaml'
require './custom_search.rb'
require './twitter.rb'

if !ARGV[0]
  p 'Please enter a tweet into the first argument!'
  exit(0)
end

config = YAML.load_file 'config.yml'

# SearchImage
custom_search = CustomSearch.new
url = custom_search.get_custom_search_api_url
url = URI.escape(url)
uri = URI.parse(url)
res = custom_search.get_search_result_json(uri)
result_json = JSON.parse(res.body)

# Download a image file
key = rand(10)
file_name = File.basename(result_json['items'][key]['link'])
file_path = config['TMP_DIR'] + file_name
open(file_path, 'wb') do |output|
  open(result_json['items'][key]['link']) do |data|
    output.write(data.read)
  end
end

# Twitter
twitter = Tweet.new
twitter.tweet(ARGV[0])
