module BriteAPI
  class IpAPIClient < BriteAPI::APIClient
    API_HATH = '/ips.json'


    def verify(value)
      get API_HOST + API_HATH, { :address => value }
    end

  end
end