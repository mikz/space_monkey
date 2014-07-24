require 'forwardable'

module SpaceMonkey
  class Client
    extend Forwardable

    # @return [SpaceMonkey::Connection]
    attr_reader :connection

    # @return [SpaceMonkey::AccountClient]
    attr_reader :account

    # @return [SpaceMonkey::InodeClient]
    attr_reader :inode

    # @return [SpaceMonkey::FileClient]
    attr_reader :file

    def_delegator :@account, :login

    # @param options [SpaceMonkey::Connection::Options]
    def initialize(**options)
      @connection = SpaceMonkey.connection(options)

      @account = SpaceMonkey::AccountClient.new(@connection)
      @inode = SpaceMonkey::InodeClient.new(@connection)
      @file = SpaceMonkey::FileClient.new(@connection)
    end

    def status
      @connection.get('status').body
    end
  end
end
