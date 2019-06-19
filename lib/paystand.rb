# API operations
require 'pay_stand/api_operations/common'
require 'pay_stand/api_operations/customer'
require 'pay_stand/api_operations/platform'

# Common code
require 'helpers/hash_utils'
require 'pay_stand/config'
require 'pay_stand/object'
require 'pay_stand/client'
require 'pay_stand/request'
require 'pay_stand/response'
require 'pay_stand/error_handler'
require 'pay_stand/resource'
require 'pay_stand/errors'

# PayStand resources
require 'pay_stand/balance'
require 'pay_stand/bank'
require 'pay_stand/card'
require 'pay_stand/customer'
require 'pay_stand/payer'
require 'pay_stand/payment'
require 'pay_stand/refund'
require 'pay_stand/recoup'
require 'pay_stand/withdrawal'

module PayStand
  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end

  def self.configure
    yield(config)
  end
end
