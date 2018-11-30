module PayStand
  class Bank < Resource
    PATH = 'banks'.freeze
    OPERATIONS = %i[create update retrieve].freeze

    extend PayStand::APIOperations::Platform

    def verify(amounts)
      self.class.request.put(path: "#{self.class.path}/#{id}/drops", params: { amounts: amounts })
    end

    def drops
      self.class.request.post(path: "#{self.class.path}/#{id}/drops")
    end
  end
end
