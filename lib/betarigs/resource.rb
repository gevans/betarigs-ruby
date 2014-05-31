module Betarigs
  class Resource
    extend Forwardable
    include Requests

    attr_reader :attributes

    alias_method :to_hash, :attributes
    alias_method :as_json, :attributes

    def initialize(api_key = nil, attrs = {})
      @api_key    = api_key
      @attributes = attrs
    end

    class << self

      def attributes(*keys)
        @attributes ||= []
        return @attributes if keys.empty?
        keys = keys.collect(&:to_s)
        @attributes << keys
        @attributes.flatten!

        keys.each do |key|
          class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def #{key}
              read_attribute(#{key.inspect})
            end

            def #{key}?
              #{key}.respond_to?(:empty?) ? !!#{key}.empty? : !#{key}
            end
          RUBY
        end
      end
    end # self

    def read_attribute(name)
      attributes[name.to_s]
    end
    alias_method :[], :read_attribute

    def reload
      self
    end

    def inspect
      inspection = @attributes.collect { |k, v| "#{k}: #{v.inspect}" }
      "#<#{self.class.name} #{inspection * ', '}>"
    end
  end # Resource
end # Betarigs
