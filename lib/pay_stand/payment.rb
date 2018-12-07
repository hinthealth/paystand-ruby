module PayStand
  class Payment < Resource
    PATH = 'payments'.freeze
    OPERATIONS = %i[create update retrieve].freeze

    extend PayStand::APIOperations::Platform

    nested_resource :refund

    def self.create(params = {})
      request.post(path: "#{path}/secure", params: params)
    end

    def self.retrieve_balance_change(balance_change_id)
      request.get(path: "#{path}/balances/changes/#{balance_change_id}")
    end

    def balances
      self.class.request.get(path: "#{self.class.path}/#{id}/balances/")
    end
  end
end
