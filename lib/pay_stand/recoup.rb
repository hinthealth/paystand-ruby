module PayStand
  class Recoup < Resource
    PATH = 'recoups'.freeze
    OPERATIONS = %i[retrieve].freeze

    extend PayStand::APIOperations::Platform
  end
end
