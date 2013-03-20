module BriteAPI

  class Contact

    #attr_accessor :email
    #attr_accessor :phone
    #attr_accessor :address
    #attr_accessor :name
    #attr_accessor :ip
    FIELDS = [:email, :phone, :address, :name, :ip]

    # Define accessors
    FIELDS.each do |f|
      define_method f do
        @data[f]
      end
      define_method "#{f}=" do |val|
        @data[f] = val
      end
    end

    def initialize(api_key, options, data = {})
      @api_key = api_key
      @options = options
      @data = data
    end

    def verify!
      # Grab fields to check
      data = @data.select{ |_, v| v != nil }
      data.keys.each do |key|
        # send async requests
      end
      # ...

      nil
    end

    def valid?
      nil
    end

    def status
      nil
    end

    def errors
      []
    end

  end
end