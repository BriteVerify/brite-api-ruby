module BriteAPI
  class NameAPIClient < BriteAPI::APIClient
    API_HATH = '/names.json'


    def verify(value)
      get API_HOST + API_HATH, { :fullname => value }
    end

  end
end