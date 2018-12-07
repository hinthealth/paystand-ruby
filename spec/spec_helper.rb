require 'coveralls'

Coveralls.wear!
SimpleCov.start do
  add_filter '/spec/'
end

require 'bundler/setup'
require 'webmock/rspec'
require_relative './../lib/paystand'
require_relative './../lib/pay_stand/testing'

WebMock.disable_net_connect!(allow_localhost: true)

PayStand.configure do |config|
  config.env = :dev
  config.platform_customer_id = '1234'
  config.publishable_key = 'key_1234'
end

 RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do |example|
    PayStand::Testing.enable if example.metadata[:mock_paystand]
  end

  config.after(:each) do |example|
    PayStand::Testing.disable if example.metadata[:mock_paystand]
  end
end
