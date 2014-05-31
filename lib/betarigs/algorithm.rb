module Betarigs
  class Algorithm < Resource

    attributes :id, :name, :market_price, :rented_capacity, :available_capacity

    def rigs(params = {})
      params[:algorithm] ||= attributes['id']
      get('rigs', params).body['items'].collect { |attrs|
        Rig.new(@api_key, attrs.merge('algorithm' => self))
      }
    end

    def reload
      @loaded = true
      @attributes.replace get("algorithm/#{id}").body
      self
    end

    def read_attribute(name)
      reload unless @loaded
      super
    end
    alias_method :[], :read_attribute
  end # Algorithm
end # Betarigs
