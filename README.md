brite-api-ruby
==============

The official BriteVerify API Client for Ruby

# Usage

```ruby
client = BriteAPI::Client.new(api_key)

contact = client.contacts.create(email: 'fake@example.com', name: 'James Bond', ip: '123.213.123.123', phone: '+12345678')

# Alternative way:
# contact = BriteAPI::Contact.new(api_key, options, data)

# Set and read values in runtime
contact.name = 'Santa Claus'
contact.address = {street: '120 N Cedar', unit: 'Apt 3201', zip: '28210'}

# Send verification requests
contact.verify!
# => false

contact.valid?
# => false

contact.errors
# => {:phone=>"Invalid format", :email=>"Email address invalid"}

contact.error_codes
# => ["invalid_format", "email_address_invalid"]

contact.status
# => "unknown"

contact.response[:name]
# => {"fullname"=>"Santa Claus","prefix"=>nil, "prefix2"=>nil,...}
```