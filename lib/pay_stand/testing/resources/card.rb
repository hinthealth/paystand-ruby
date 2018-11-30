require 'active_support/core_ext/integer/time'

module PayStand
  class Card < Resource
    def self.update(id, params = {})
      return super unless PayStand::Testing.enabled?

      Data.instance.update :card, id, default.merge(params)
    end

    def self.retrieve(id)
      return super unless PayStand::Testing.enabled?

      Data.instance.update :card, id, default
    end

    def self.default
      expire_date = 1.year.from_now
      {
        name_on_card: 'John Doe',
        card_number: '4000000000000077',
        security_code: '123',
        expiration_month: expire_date.strftime('%m'),
        expiration_year: expire_date.strftime('%Y'),
        billingAddress: {
          street1: '923 test account st',
          street2: '9g',
          city: 'santa cruz',
          state: 'CA',
          postalCode: '90040',
          country: 'USA'
        }
      }
    end
  end
end
