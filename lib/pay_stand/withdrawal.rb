module PayStand
  class Withdrawal < Resource
    PATH = 'withdrawals/'.freeze
    OPERATIONS = %i[create update retrieve].freeze

    extend PayStand::APIOperations::Customer

    def self.settings(customer_id, accounts:, frequency: 'daily')
      params = {
        auto: {
          frequency: frequency,
          active: accounts.keys,
          accounts: accounts,
        },
      }
      request(customer_id).put(path: "#{path}/settings", params: params)
    end
  end
end
