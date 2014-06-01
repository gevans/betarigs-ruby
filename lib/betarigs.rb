require 'forwardable'

require 'betarigs/version'
require 'betarigs/client'

module Betarigs
  extend self

  def middleware(&block)
    block_given? ? @middleware = block : @middleware
  end
end
