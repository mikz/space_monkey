module SpaceMonkey
  class BaseClient
    def initialize(connection = SpaceMonkey.connection)
      @connection = connection
    end
  end
end
