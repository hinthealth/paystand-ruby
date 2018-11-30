module PayStand
  class Withdrawal < Resource
    def self.create(customer_id, params = {})
      return super unless PayStand::Testing.enabled?

      Data.instance.create :withdrawal, default.merge(params)
    end

    def self.update(customer_id, id, params = {})
      return super unless PayStand::Testing.enabled?

      Data.instance.update :withdrawal, id, default.merge(params)
    end

    def self.retrieve(customer_id, id)
      return super unless PayStand::Testing.enabled?

      Data.instance.retrieve :withdrawal, id
    end

    def self.settings(customer_id, frequency: 'daily', accounts:)
      return super unless PayStand::Testing.enabled?

      Response.new(
        auto: {
          frequency: frequency,
          active: accounts.keys,
          accounts: accounts
        }
      ).convert_to_object
    end

    def self.default
      bank = Data.instance.create :bank, Bank.default
      {
        bank_id: bank.id,
        amount: rand(100),
        currency: 'USD',
        description: 'Create withdrawal',
        status: 'posted',
      }
    end
  end
end
