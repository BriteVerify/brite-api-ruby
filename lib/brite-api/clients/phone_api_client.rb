module BriteAPI
  class PhoneAPIClient < BriteAPI::APIClient
    API_HATH = '/phones.json'


    def verify(value)
      get API_HOST + API_HATH, { :number => value }
    end

  end
end