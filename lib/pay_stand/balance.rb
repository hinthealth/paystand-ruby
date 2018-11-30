module PayStand
  class Balance < Resource
    PATH = 'balances/'.freeze

    extend PayStand::APIOperations::Customer

    def self.summary(customer_id, params = {})
      request(customer_id).get(path: "#{path}/summary", params: params)
    end
  end
end
