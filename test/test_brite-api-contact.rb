require 'helper'

class TestBriteApiClient < Test::Unit::TestCase
  context "Test Contact" do
    setup do
      config = YAML.load File.read 'config.yml'
      @api_key = config['test']['api_key']
      @client = BriteAPI::Client.new(@api_key)
    end

    should "create empty contact" do
      contact = @client.create({})

      assert contact.is_a?(BriteAPI::Contact)
      assert_equal contact.email, nil
      assert_equal contact.name, nil
      assert_equal contact.phone, nil
      assert_equal contact.address, nil
      assert_equal contact.ip, nil
    end

    should "allow direct call" do
      contact = BriteAPI::Contact.new(@api_key, {}, {:email => 'foo@example.com'})

      assert contact.is_a?(BriteAPI::Contact)
      assert_equal contact.email, 'foo@example.com'
      assert_equal contact.name, nil
      assert_equal contact.phone, nil
      assert_equal contact.address, nil
      assert_equal contact.ip, nil
    end

    should "process empty contact without errors" do
      contact = @client.create({})

      contact.verify!

      assert_equal contact.valid?, nil
      assert_equal contact.status, nil
      assert_equal contact.errors, {}
      assert_equal contact.error_codes, []
    end

    should "work without verifying" do
      contact = @client.create({:email => 'foo@example.com', name: 'John Smith'})

      assert_equal contact.valid?, nil
      assert_equal contact.status, nil
      assert_equal contact.errors, {}
      assert_equal contact.error_codes, []

      assert_equal contact.email, 'foo@example.com'
      assert_equal contact.name, 'John Smith'
      assert_equal contact.phone, nil
      assert_equal contact.address, nil
      assert_equal contact.ip, nil
    end

    should "verify valid email" do
      contact = @client.create({:email => 'admin@yahoo.com'}).verify!

      assert_equal contact.valid?, true
      assert_equal contact.status, 'valid'
      assert_equal contact.errors, {}
      assert_equal contact.error_codes, []
    end

    should "verify valid email with verify_connected option" do
      contact = BriteAPI::Contact.new(@api_key, {:verify_connected => true}, {:email => 'admin@yahoo.com'}).verify!

      assert_equal contact.valid?, true
      assert_equal contact.status, 'valid'
      assert_equal contact.errors, {}
      assert_equal contact.error_codes, []
    end

    should "verify invalid email" do
      contact = @client.create({:email => 'foo@example.com'}).verify!

      assert_equal contact.valid?, false
      assert_equal contact.status, 'invalid'
      assert_equal contact.errors[:email], "Email domain invalid"
      assert_equal contact.error_codes, ["email_domain_invalid"]
    end


    should "verify valid name" do
      contact = @client.create({:name => "John Smith"}).verify!

      assert_equal contact.valid?, true
      assert_equal contact.status, 'valid'
      assert_equal contact.errors, {}
      assert_equal contact.error_codes, []
    end

    should "verify invalid name" do
      contact = @client.create({:name => "123456789"}).verify!

      assert_equal contact.valid?, false
      assert_equal contact.status, 'invalid'
      assert_equal contact.errors[:name], "Contains non alphabetic"
      assert_equal contact.error_codes, ["contains_non_alphabetic"]
    end

    should "verify valid ip" do
      contact = @client.create({:ip => "8.8.8.8"}).verify!

      assert_equal contact.valid?, true
      assert_equal contact.status, 'valid'
      assert_equal contact.errors, {}
      assert_equal contact.error_codes, []
    end


    should "verify invalid ip" do
      contact = @client.create({:ip => "256.256.256.256"}).verify!

      assert_equal contact.valid?, false
      assert_equal contact.status, 'invalid'
      assert_equal contact.errors[:ip], "Invalid format"
      assert_equal contact.error_codes, ["invalid_format"]
    end

    should "verify valid phone" do
      contact = @client.create({:phone => "8132000000"}).verify!

      assert_equal contact.valid?, true
      assert_equal contact.status, 'valid'
      assert_equal contact.errors, {}
      assert_equal contact.error_codes, []
    end


    should "verify invalid phone" do
      contact = @client.create({:phone => "123456789"}).verify!

      assert_equal contact.valid?, false
      assert_equal contact.status, 'invalid'
      assert_equal contact.errors[:phone], "Invalid format"
      assert_equal contact.error_codes, ["invalid_format"]
    end


    should "verify valid address" do
      contact = @client.create(:address => {:street => '120 N Cedar', :unit => 'Apt 3201', :zip => '28210'}).verify!

      assert_equal contact.valid?, true
      assert_equal contact.status, 'valid'
      assert_equal contact.errors, {}
      assert_equal contact.error_codes, []
    end

    should "verify invalid address" do
      contact = @client.create(:address => {:street => 'foo bar baz', :zip => '999999'}).verify!

      assert_equal contact.valid?, false
      assert_equal contact.status, 'invalid'
      assert_equal contact.errors[:address], "Zip code invalid"
      assert_equal contact.error_codes, ["zip_code_invalid"]
    end

    should "verify full contact" do
      contact = @client.create(
        :name => "123456789",
        :email => 'foo@example.com',
        :phone => "123456789",
        :address => {:street => 'foo bar baz', :zip => '999999'},
        :ip => "256.256.256.256"
      ).verify!

      assert_equal contact.valid?, false
      assert_equal contact.status, 'invalid'
      assert_equal contact.errors.count, 5
      assert_equal contact.error_codes.count > 0, true
    end












  end


end
