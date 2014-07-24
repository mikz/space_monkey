module SpaceMonkey
  class BaseClient

    # @return [SpaceMonkey::Connection]
    attr_reader :connection

    def initialize(connection = SpaceMonkey.connection)
      @connection = connection
    end
  end
end
