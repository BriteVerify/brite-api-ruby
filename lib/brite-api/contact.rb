module BriteAPI

  class Contact

    attr_reader :response

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

    def initialize(api_key, options = {}, data = {})
      @api_key = api_key
      @options = options
      @data = {}
      data.each { |k, v| @data[k.to_sym] = v }

      @response = {}
    end

    def verify!
      @response = {}

      data = @data.select{ |_, v| v != nil }

      # send async requests
      threads = []
      data.each do |key, value|

        threads << Thread.new(key, value) do |k, v|
          klass = BriteAPI.const_get(k.to_s.capitalize + "APIClient")
          @response[k] = klass.new(@api_key, @options).verify(v)
        end
      end

      threads.each { |thr| thr.join }

      valid?
    end

    def valid?
      return if @response == {}
      @response.all?{ |_, data| data['status'] == 'valid' }
    end

    def status
      return if @response == {}
      states = ['valid', 'unknown', 'invalid']
      states.each_with_index do |state, index|
        return state if @response.all?{ |_, data| states[0, index].include? data['status'] }
      end
      'unknown'
    end

    def errors
      err = {}
      @response.each do |key, data|
        err[key] = data['error'] if data['error']
      end
      err
    end

    def error_codes
      @response.map{ |_, data| data['error_code'] }.compact
    end

  end
end