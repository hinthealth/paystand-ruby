require 'active_support/core_ext/hash/indifferent_access'

module PayStand
  class Data
    RESOURCES = %i[payment bank card customer withdrawal refund recoup]
    include Singleton

    RESOURCES.each do |resource|
      attr_accessor resource.to_s.pluralize.to_sym
    end

    def initialize
      reset
    end

    def create(resource_name, resource)
      check_valid_resource(resource_name)
      paystand_object = Response.new(build_resource(resource, resource_name)).convert_to_object
      write(resource_name, paystand_object.id, paystand_object)
      paystand_object
    end

    def retrieve(resource_name, id)
      check_valid_resource(resource_name)
      read(resource_name, id)
    end

    def update(resource_name, id, resource)
      check_valid_resource(resource_name)
      paystand_object = Response.new(build_resource(resource, resource_name, id)).convert_to_object
      write(resource_name, id, paystand_object)
      paystand_object
    end

    def reset
      RESOURCES.each do |resource|
       instance_variable_set("@#{resource.to_s.pluralize}", {})
     end
    end

    private

    def build_resource(resource, resource_name, id = nil)
      id ||= "#{resource_name}_#{rand(1000)}"
      resource.merge(id: id, object: resource_name.to_s).with_indifferent_access
    end

    def check_valid_resource(resource_name)
      raise UnregisteredMock unless RESOURCES.include?(resource_name)
    end

    def read(resource_name, id)
      self.send("#{resource_name.to_s.pluralize}")[id]
    end

    def write(resource_name, id, data)
      self.send("#{resource_name.to_s.pluralize}")[id] = data
    end
  end
end
