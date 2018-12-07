module PayStand
  class Refund < Resource
    PATH = 'refunds'.freeze
    OPERATIONS = %i[update retrieve].freeze

    extend PayStand::APIOperations::Platform

    nested_resource :recoup
  end
end
