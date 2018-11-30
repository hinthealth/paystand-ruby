module PayStand
  class BalanceAccount < Resource
    PATH = 'balances/accounts'.freeze
    OPERATIONS = %i[create update retrieve].freeze

    extend PayStand::APIOperations::Customer
  end
end
