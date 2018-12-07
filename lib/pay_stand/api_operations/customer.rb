module PayStand
  module APIOperations
    module Customer
      include Common

      def list(customer_id, params = {})
        validate_operation __method__
        request(customer_id).get(path: path, params: params)
      end

      def create(customer_id, params = {})
        validate_operation __method__
        request(customer_id).post(path: path, params: params)
      end

      def retrieve(customer_id, id)
        validate_operation __method__
        request(customer_id).get(path: "#{path}/#{id}")
      end

      def update(customer_id, id, params)
        validate_operation __method__
        request(customer_id).put(path: "#{path}/#{id}", params: params)
      end

      def request(customer_id)
        Request.new(customer_id: customer_id)
      end
    end
  end
end
