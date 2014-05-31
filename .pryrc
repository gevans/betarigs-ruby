require 'bundler/setup'
require 'betarigs'

include Betarigs

def reload!
  old_verbose, $VERBOSE = $VERBOSE, nil
  Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].sort.each { |f| load f }
ensure
  $VERBOSE = old_verbose
end
