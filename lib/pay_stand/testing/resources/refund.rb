module PayStand
  class Refund < Resource
    def self.update(id, params = {})
      return super unless PayStand::Testing.enabled?

      Data.instance.update :refund, id, default.merge(params)
    end

    def self.retrieve(id)
      return super unless PayStand::Testing.enabled?

      Data.instance.retrieve :refund, id
    end

    def self.create_recoup(id, params)
      return super unless PayStand::Testing.enabled?

      referenced_resources = {
        refund_id: id,
        payment_id: Data.instance.retrieve(:refund, id).payment_id
      }
      Data.instance.create :recoup, Refund.default.merge(referenced_resources).merge(params)
    end

    def self.default
      {
        status: 'paid',
        currency: 'USD',
      }
    end
  end
end
