require 'space_monkey/version'

module SpaceMonkey
  autoload :Client, 'space_monkey/client'
  autoload :AccountClient, 'space_monkey/account_client'
  autoload :Inode, 'space_monkey/inode'
  autoload :InodeClient, 'space_monkey/inode_client'
  autoload :FileClient, 'space_monkey/file_client'
  autoload :File, 'space_monkey/file'
  autoload :Folder, 'space_monkey/folder'
  autoload :Record, 'space_monkey/record'
  autoload :Connection, 'space_monkey/connection'
  autoload :CLI, 'space_monkey/cli'
  autoload :ApiParams, 'space_monkey/api_params'

  autoload :BaseClient, 'space_monkey/base_client'
  autoload :ShareClient, 'space_monkey/share_client'
  autoload :Share, 'space_monkey/share'

  # @return [Connection]
  def self.default_connection
    # TODO: add a mutex
    @@default_connection ||= SpaceMonkey::Connection.new
  end

  # @param [Connection::Options]
  # @return [Connection]
  def self.connection(options = {})
    options.empty? ? default_connection : SpaceMonkey::Connection.new(options)
  end
end
