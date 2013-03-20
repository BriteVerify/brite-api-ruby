module BriteAPI
  class APIClient
    API_HOST = 'bpi.briteverify.com'

    def initialize(api_key, options = {})
      @api_key = api_key
      @rest = Rest::Client.new(:gem => options[:gem])
    end


    def get(url, params = {})

      options = {
        :params => params.merge(:apikey => @api_key)
      }
      @rest.get(url, options)
    end

  end
end