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

      def nested_resource(name)
       define_method "create_#{name}" do |params|
         self.class.send("create_#{name}", id, params)
       end

       define_singleton_method "create_#{name}" do |id, params|
         request.post(path: "#{path}/#{id}/#{name.to_s.pluralize}", params: params)
       end
     end

      private

      def error_message(method_name)
        "#{method_name} operation isn't included in the list of available " \
        "operations (#{operations.join(',')})"
      end
    end
  end
end
