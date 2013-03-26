require 'rest'
require 'json'

module BriteAPI
  class APIClient
    API_HOST = 'https://bpi.briteverify.com'

    def initialize(api_key, options = {})
      @api_key = api_key
      @options = options
      @rest = Rest::Client.new(:gem => options[:gem])
    end

    def verify(value)
      raise "Not implemented"
    end

    def get(url, params = {})

      options = {
        :params => params.merge(:apikey => @api_key)
      }

      JSON.parse @rest.get(url, options).body
    end

  end
end