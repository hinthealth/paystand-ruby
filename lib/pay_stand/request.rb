require 'faraday'
require 'faraday_middleware'
require 'json'

module PayStand
  class Request
    attr_reader :customer_id
    def initialize(customer_id:)
      fail InvalidCustomerId unless customer_id
      @customer_id = customer_id
      authorize
    end

    def get(path:, params: {})
      create_request(method: :get, path: path, params: params)
    end

    def post(path:, params: {})
      create_request(method: :post, path: path, body: params)
    end

    def put(path:, params: {})
      create_request(method: :put, path: path, body: params)
    end

    private

    def create_request(method:, path:, params: {}, body: {})
      body = HashUtils.to_camelback_keys(body)
      http_attrs = { headers: authorized_headers(customer_id), body: body, params: params }
      response = Client.execute_request(method, path, http_attrs)

      if response.body && response.success?
        Response.new(response.body).convert_to_object
      else
        PayStand::ErrorHandler.call(response.body, response.status)
      end
    end

    def authorize
      body = {
        'grant_type': 'client_credentials',
        'client_id': PayStand.config.client_id,
        'client_secret': PayStand.config.client_secret,
        'scope': 'auth',
      }

      http_attrs = { headers: unauthorized_headers, body: body }
      response = Client.execute_request(:post, 'oauth/token', http_attrs)
      @access_token = response.body['access_token']
      @token_type = response.body['token_type'] || 'Bearer'
    end

    def authorized_headers(customer_id)
      {
        'X-CUSTOMER-ID': customer_id,
        'Authorization': "#{@token_type} #{@access_token}",
      }
    end

    def unauthorized_headers
      { 'X-PUBLISHABLE-KEY': PayStand.config.publishable_key }
    end
  end
end
