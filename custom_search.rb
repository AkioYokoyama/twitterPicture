require 'uri'
require 'net/http'
require 'json'
require 'yaml'

class CustomSearch
  $config = YAML.load_file 'config.yml'

  def get_custom_search_api_url
    index = rand($config['SEARCH_RESULT_INDEX']) + 1

    url = $config['API_BASE_URL']
    url << $config['API_KEY']
    url << '&cx='
    url << $config['SEARCH_ENGINE_ID']
    url << '&q='
    url << $config['SEARCH_WORD']
    url << '&start='
    url << index.to_s
    url << '&searchType=image'
    url << '&alt=json'

    return url
  end # method end

  def get_search_result_json uri
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    res = https.start {
      https.get(uri.request_uri)
    }

    return res
  end # method end
end # class end
