require 'ostruct'
require 'forwardable'

require 'faraday'
require 'faraday-cookie_jar'
require 'faraday_middleware'

module SpaceMonkey
  class Connection

    extend Forwardable
    def_delegators :@connection, :post, :get, :put

    attr_accessor :options, :connection

    # @param options [Options]
    def initialize(**options)
      @options = SpaceMonkey::Connection::Options.new(options)
      @connection = Faraday::Connection.new(@options) do |connection|
        connection.request :url_encoded
        connection.response :json, content_type: 'application/json'
        connection.response :raise_error

        connection.use :cookie_jar

        connection.adapter options.fetch(:adapter) { Faraday.default_adapter }

        yield connection if block_given?
      end
    end

    class Options < OpenStruct
      extend Forwardable
      def_delegator :@table, :each

      DEFAULTS = { url: 'https://api.spacemonkey.com/v1/'}

      def initialize(hash = {})
        super(DEFAULTS.merge(hash))
      end

      def ==(other)
        super or @table == other
      end

      def is_a?(klass)
        super or klass == Hash
      end
    end

  end
end
