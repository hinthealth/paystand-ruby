module PayStand
  module APIOperations
    module Common
      def path
        const_get :PATH
      end

      def operations
        const_get :OPERATIONS
      end

      def validate_operation(method_name)
        fail InvalidOperation, error_message(method_name) unless operations.include? method_name
      end

      private

      def error_message(method_name)
        "#{method_name} operation isn't included in the list of available " \
        "operations (#{operations.join(',')})"
      end
    end
  end
end
