module PayStand
  class Payer < Resource
    PATH = 'payers'.freeze
    OPERATIONS = %i[create update retrieve].freeze

    extend PayStand::APIOperations::Platform
  end
end
