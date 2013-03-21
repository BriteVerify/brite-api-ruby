module BriteAPI
  class EmailAPIClient < BriteAPI::APIClient
    API_HATH = '/emails.json'


    def verify(value)
      params = { :address => value }
      if @options[:verify_connected] || @options['verify_connected']
        params[:verify_connected] = true
      end
      get API_HOST + API_HATH, params
    end

  end
end