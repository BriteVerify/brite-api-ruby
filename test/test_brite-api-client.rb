require 'helper'

class TestBriteApiClient < Test::Unit::TestCase
  context "Test API Client" do

    setup do
      config = YAML.load File.read 'config.yml'
      @api_key = config['test']['api_key']
      @client = BriteAPI::Client.new(@api_key)
    end


    should "create api client instance" do

      assert @client.create({}).is_a? BriteAPI::Contact
      assert @client.contacts.create({}).is_a? BriteAPI::Contact
    end

    should "throw error if no api key provided" do

      #assert_throws :ArgumentError do
      #  client = BriteAPI::Client.new(nil)
      #end

    end




  end

end
