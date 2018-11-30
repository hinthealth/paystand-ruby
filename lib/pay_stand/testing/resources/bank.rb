module PayStand
  class Bank < Resource
    def self.create(params = {})
      return super unless PayStand::Testing.enabled?

      Data.instance.create :bank, default.merge(params)
    end

    def self.update(id, params = {})
      return super unless PayStand::Testing.enabled?

      Data.instance.update :bank, id, default.merge(params)
    end

    def self.retrieve(id)
      return super unless PayStand::Testing.enabled?

      Data.instance.retrieve :bank, id
    end

    def verify(amounts)
      return super unless PayStand::Testing.enabled?
      if amounts == ['32', '45']
        bank = Data.instance.retrieve :bank, id
        ErrorHandler.call(Testing::ErrorGenerator.already_verified_bank, 402) if bank.verified
        bank.verified = true
        bank
      else
        ErrorHandler.call(Testing::ErrorGenerator.wrong_drop_amounts, 402)
      end
    end

    def self.default
      {
        name_on_account: 'John Doe',
        currency: 'USD',
        country: 'USA',
        accountType: 'checking',
        isDefault: true,
        billingAddress: {
          street1: '923 test account st',
          street2: '9g',
          city: 'santa cruz',
          state: 'CA',
          postalCode: '90040',
          country: 'USA'
        },
        verified: false,
        dropped: false,
        status: 'active'
      }
    end
  end
end
