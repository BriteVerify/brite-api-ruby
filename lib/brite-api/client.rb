module BriteAPI

  class Client
    def initialize(api_key, options = {})
      raise ArgumentError, "Missing BriteVerify API key" if api_key.nil? || api_key == ''
      @api_key = api_key
      @options = options
    end



    def contact_create(data = {})
      BriteAPI::Contact.new(@api_key, @options, data)
    end

    def contacts
      self
    end


    alias_method :create, :contact_create
    alias_method :contact, :contact_create


  end
end