require 'open-uri'
require 'yaml'
require './custom_search.rb'
require './twitter.rb'

config = YAML.load_file 'config.yml'

# googleCustomSearch
custom_search = CustomSearch.new
url = custom_search.get_custom_search_api_url

# 日本語のエスケープ
url = URI.escape(url)
# URLのパース
uri = URI.parse(url)

res = custom_search.get_search_result_json(uri)

resultJson = JSON.parse(res.body)

key = rand(10) + 1

file_name = File.basename(resultJson['items'][key]['link'])
file_path = config['TMP_DIR'] + file_name

open(file_path, 'wb') do |output|
  open(resultJson['items'][key]['link']) do |data|
    output.write(data.read)
  end
end

# Twitter
twitter = Tweet.new
twitter.tweet('')
