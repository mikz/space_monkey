
module SpaceMonkey
  class Client

    attr_accessor :connection

    attr_accessor :account

    def initialize(**options)
      @connection = SpaceMonkey.connection(options)
      @account = SpaceMonkey::Account.new(@connection)
    end
  end
end
