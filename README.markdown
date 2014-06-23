# Ptilinopus

API Wrapper for [MailerLite](http://mailerlite.com/)
Inspired by [Gibbon](https://github.com/amro/gibbon/)

## Installation

Add this line to your application's Gemfile:

    gem 'ptilinopus'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ptilinopus

## Usage

First of all setup your API key:
    
    api = Ptilinopus::API.new("api_key")

or

    Ptilinopus::API.api_key = "api_key"

If you setup key with the second case you can make API call on the class itself:

    Ptilinopus::API.call(:post, "subscribers/unsubscribe", {email: "test_email@test.com"})


### Call API methods

Fetch groups:

    api = Primary::API.new("api_key")
    api.call(:get, "lists")

Adding a subscriber:

    api = Primary::API.new("api_key")
    api.call(:post, "subscribers", {email: 'test_email@test.com', id: 123456})

List of all methods you can find here [http://docs.mailerlite.com/]

> Note: specify :get and :post types according to API documentaion

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
