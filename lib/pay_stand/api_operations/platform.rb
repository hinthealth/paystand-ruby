module PayStand
  module APIOperations
    module Platform
      include Common

      def create(params = {})
        validate_operation __method__
        request.post(path: path, params: params)
      end

      def retrieve(id)
        validate_operation __method__
        request.get(path: "#{path}/#{id}")
      end

      def update(id, params)
        validate_operation __method__
        request.put(path: "#{path}/#{id}", params: params)
      end

      def request
        Request.new(customer_id: customer_id)
      end

      private

      def customer_id
        PayStand.config.platform_customer_id
      end
    end
  end
end
