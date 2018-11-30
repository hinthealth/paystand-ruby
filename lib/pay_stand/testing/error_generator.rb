module PayStand
  module Testing
    module ErrorGenerator
      extend self

      def payment_card_declined
        invalid_request_error(description: 'There was a problem with the card resource.',
                              explanation: 'Generic decline',
                              code: 'cardFailure')
      end

      def wrong_drop_amounts
        invalid_request_error(description: 'There was a problem with the bank resource.',
                              explanation: 'The bank drops are wrong',
                              code: 'bankFailure')
      end

      def already_verified_bank
        invalid_request_error(description: 'There was a problem with the bank resource.',
                              explanation: 'The bank drops have already been verified',
                              code: 'bankFailure')
      end

      private

      def invalid_request_error(description:, explanation:, code: 'validationError')
        {
          error: {
            details: {
              code: code,
              description: description,
              explanation: explanation,
            },
          },
        }.with_indifferent_access
      end
    end
  end
end
