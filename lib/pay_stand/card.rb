module PayStand
  class Card < Resource
    PATH = 'cards'.freeze
    OPERATIONS = %i[update retrieve].freeze

    extend PayStand::APIOperations::Platform
  end
end
