module PayStand
  class Recoup < Resource
    def self.retrieve(id)
      return super unless PayStand::Testing.enabled?

      Data.instance.retrieve :recoup, id
    end

    def self.default
      {
        status: 'paid',
        currency: 'USD',
      }
    end
  end
end
