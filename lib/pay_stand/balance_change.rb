module PayStand
  class BalanceChange < Resource
    PATH = 'payments/balances/changes'.freeze
    OPERATIONS = %i[retrieve].freeze

    extend PayStand::APIOperations::Platform
  end
end
