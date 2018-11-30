module RequestTesting
  def initialize(customer_id:)
    return super unless PayStand::Testing.enabled?
  end

  private

  def create_request(method:, path:, params: {}, body: {})
    return super unless PayStand::Testing.enabled?
    raise PayStand::UnregisteredMock, "#{method} #{path}"
  end
end

module PayStand
  class Request
    prepend RequestTesting
  end
end
