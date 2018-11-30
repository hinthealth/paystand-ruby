module PayStand
  class Payment < Resource
    def self.create(params = {})
      return super unless PayStand::Testing.enabled?
      if response = Testing.response(:create_payment)
        ErrorHandler.call(response[:body], response[:status])
      else
        params.delete(:transfers) if params[:transfers]
        Data.instance.create :payment, default.merge(params)
      end
    end

    def self.update(id, params = {})
      return super unless PayStand::Testing.enabled?

      Data.instance.update :payment, id, default.merge(params)
    end

    def self.retrieve(id)
      return super unless PayStand::Testing.enabled?

      Data.instance.retrieve :payment, id
    end

    def self.default
      {
        status: 'paid',
        disputes: [],
        currency: 'USD',
        fees: [],
        holds: [],
        transfer_type: 'simple'
      }
    end
  end
end
