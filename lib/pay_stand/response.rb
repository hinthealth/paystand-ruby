require 'active_support/core_ext/string' # we can replace it with dry-inflector

module PayStand
  class Response
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def convert_to_object
      return unless response

      convert_data_to_objects(response.deep_transform_keys { |key| key.to_s.underscore })
    end

    private

    def convert_data_to_objects(data)
      case data
      when Array
        data.map { |o| convert_data_to_objects(o) }
      when Hash
        convert_hash_to_object(data)
      else
        data
      end
    end

    def convert_hash_to_object(hash)
      begin
        object_klass = hash.fetch('object')&.classify
        klass = "PayStand::#{object_klass}".constantize
      rescue NameError, KeyError
        klass = Object
      end
      convert_nested_data_to_objects(hash)
      klass.new(hash)
    end

    def convert_nested_data_to_objects(hash)
      hash.each do |key, value|
        hash[key] = convert_data_to_objects(value)
      end
    end
  end
end
