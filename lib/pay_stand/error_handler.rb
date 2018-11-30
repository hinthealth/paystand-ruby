module PayStand
  module ErrorHandler
    extend self

    def call(body, status)
      error_details = body.dig('error', 'details')
      error_message = error_details&.dig('explanation')
      error_code = error_details&.dig('code')

      case status
      when 402
        fail(CardError, error_message) if error_code == 'cardFailure'
        fail(InvalidRequestError, error_message)
      when 401
        fail(AuthenticationError, error_message)
      when 404, 422
        fail(InvalidRequestError, error_message)
      when 400
        if error_code == 'apiError'
          error_message ||= api_error_message(error_details)
          fail(APIError, error_message)
        end
      when 500
        fail(APIError, error_message)
      when 503
        fail(APIConnectionError)
      end
      # we didn't catch what kind of error was, so it's the generic one
      fail(PayStandError, error_message)
    end

    private

    def api_error_message(error_details)
      api_error_code = error_details.dig('detailCode')
      parameter_missing = error_details.dig('parameter')
      return api_error_code unless api_error_code

      "#{parameter_missing} is missing" if api_error_code == 'parameterMissing'
    end
  end
end
