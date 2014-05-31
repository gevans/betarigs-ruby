require 'betarigs/algorithm'

module Betarigs
  class AlgorithmCollection
    extend Forwardable
    include Enumerable
    include Requests

    def_delegators :algorithms, :[], :each

    def initialize(api_key = nil)
      @api_key = api_key
    end

    def algorithms
      @algorithms ||= get('algorithms').body.collect { |attrs|
        Algorithm.new(@api_key, attrs)
      }
    end
    alias_method :all, :algorithms
  end # AlgorithmCollection
end # Betarigs
