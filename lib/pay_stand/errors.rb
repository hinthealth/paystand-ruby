module PayStand
  class PayStandError < StandardError; end

  class InvalidOperation < PayStandError
    def initialize(msg = "The operation isn't included in the list of available operations")
      super
    end
  end

  class InvalidCustomerId < PayStandError; end

  class CardError < PayStandError
    def initialize(msg)
      msg = 'The card was declined' if msg.blank? || msg == 'Generic decline'
      super(msg)
    end
  end

  class InvalidRequestError < PayStandError; end
  class APIError < PayStandError; end
  class AuthenticationError < PayStandError; end
  class APIConnectionError < PayStandError; end
  class UnregisteredMock < PayStandError; end
  class TimeoutError < PayStandError; end
end
