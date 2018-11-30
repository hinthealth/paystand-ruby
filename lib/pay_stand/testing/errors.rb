module PayStand
  module Testing
    module Errors
      @responses = {}
      def prepare_card_error(code)
        @responses ||= {}
        case code
        when :card_declined
          @responses[:create_payment] = {
            body: ErrorGenerator.payment_card_declined,
            status: 402,
          }
        end
      end

      def response(response_method)
        @responses && @responses[response_method]
      end

      def reset
        @responses = {}
      end
    end
  end
end
