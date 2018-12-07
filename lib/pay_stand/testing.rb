require 'webmock'

require 'pay_stand/testing/config'
require 'pay_stand/testing/data'
require 'pay_stand/testing/request'
require 'pay_stand/testing/errors'
require 'pay_stand/testing/error_generator'
require 'pay_stand/testing/resources/bank'
require 'pay_stand/testing/resources/card'
require 'pay_stand/testing/resources/customer'
require 'pay_stand/testing/resources/payment'
require 'pay_stand/testing/resources/recoup'
require 'pay_stand/testing/resources/refund'
require 'pay_stand/testing/resources/withdrawal'

module PayStand
  module Testing
    extend PayStand::Testing::Config
    extend PayStand::Testing::Errors
  end
end

PayStand::Testing.disable # default behavior
