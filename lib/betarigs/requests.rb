require 'faraday'
require 'faraday_middleware'

module Betarigs
  ##
  # Shares behavior for making HTTP requests to Betarigs.
  module Requests

    CA_FILE = File.expand_path('../../../resources/ca-bundle.crt', __FILE__)

    ENDPOINT = 'https://www.betarigs.com/api/v1/'.freeze

    USER_AGENT = 'betarigs-ruby/%s (Rubygems; Ruby %s %s; +https://github.com/gevans/betarigs-ruby)' % [
      Betarigs::VERSION, RUBY_VERSION, RUBY_PLATFORM
    ]

    protected

    %w[get post put delete head patch].each do |method|
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(*arguments, &block)
          http.#{method}(*arguments, &block)
        end
      RUBY
    end

    def http
      @http ||= Faraday.new(ENDPOINT, http_options) do |conn|
        conn.request  :json
        conn.response :json, content_type: /\bjson$/

        conn.adapter Faraday.default_adapter
      end
    end

    def http_options
      {
        headers: {
          accept:     'application/json',
          user_agent: USER_AGENT
        },
        request: {
          open_timeout: 5,
          timeout:      5
        },
        ssl: {
          verify_mode: OpenSSL::SSL::VERIFY_PEER,
          ca_file:     CA_FILE
        }
      }
    end
  end # Requests
end # Betarigs
