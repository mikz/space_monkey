require 'forwardable'

module SpaceMonkey
  class Client
    extend Forwardable

    attr_accessor :connection

    attr_accessor :account, :inode, :file

    def_delegator :@account, :login

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
