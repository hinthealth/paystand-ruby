module PayStand
  class Customer < Resource
    PATH = 'customers'.freeze
    OPERATIONS = %i[create update retrieve].freeze

    extend PayStand::APIOperations::Platform

    def self.create(params = {})
      request.post(path: "#{path}/accounts", params: params)
    end

    def self.list
      request.get(path: "#{path}/accounts").results
    end

    def self.find_by(merchant_key:)
      list.detect { |customer| customer.merchant_key == merchant_key }
    end
  end
end
