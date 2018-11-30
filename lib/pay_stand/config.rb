module PayStand
  class Config
    attr_accessor :client_id, :client_secret, :publishable_key, :platform_customer_id, :log_enabled, :env

    def initialize
      @client_id = nil
      @client_secret = nil
      @publishable_key = nil
      @platform_customer_id = nil
      @log_enabled = false
      @env = :production
    end
  end
end
