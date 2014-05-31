require 'betarigs/requests'
require 'betarigs/resource'
require 'betarigs/algorithm_collection'
require 'betarigs/rig'

module Betarigs
  class Client
    include Requests

    def initialize(api_key = nil)
      @api_key = api_key
    end

    def algorithms
      @algorithms ||= AlgorithmCollection.new(@api_key)
    end

    #def rigs(algorithm_id, opts = {})
    #  get('rigs', opts.merge(algorithm: algorithm_id)).body['items']
    #end
  end # Client
end # Betarigs
