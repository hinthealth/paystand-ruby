module PayStand
  module Client
    extend self

    def execute_request(method, path, headers:, body: nil, params: nil)
      fail NameError unless %i[post put get].include?(method)
      response = connection.public_send(method) do |request|
        request.url path
        request.headers = headers
        request.body = JSON.generate(body) if body
        request.params = params if params
      end
    rescue Faraday::TimeoutError, Faraday::ConnectionFailed
      raise PayStand::TimeoutError
    end

    def base_url
      @base_url ||= begin
        subdomain = {
          dev: 'info',
          sandbox: 'co',
          production: 'com',
        }[environment]
        "https://api.paystand.#{subdomain}/v3"
      end
    end

    private

    def connection
      Faraday.new(url: base_url, ssl: { verify: environment != :dev }) do |connection|
        connection.request :json
        connection.response :json
        connection.response :logger if PayStand.config.log_enabled
        connection.adapter Faraday.default_adapter
      end
    end

    def environment
      PayStand.config.env
    end
  end
end
