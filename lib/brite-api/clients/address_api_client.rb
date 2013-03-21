module BriteAPI
  class AddressAPIClient < BriteAPI::APIClient
    API_HATH = '/addresses.json'


    def verify(value)
      raise "Address should be a Hash" unless value.respond_to? :each
      params = {}
      value.each do |k, v|
        params["address[#{k}]"] = v
      end

      get API_HOST + API_HATH, params
    end

  end
end