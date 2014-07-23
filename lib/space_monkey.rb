require 'space_monkey/version'

module SpaceMonkey
  autoload :Client, 'space_monkey/client'
  autoload :Account, 'space_monkey/account'
  autoload :Connection, 'space_monkey/connection'
  autoload :CLI, 'space_monkey/cli'

  def self.default_connection
    # TODO: add a mutex
    @@default_connection ||= SpaceMonkey::Connection.new
  end

  def self.connection(options = {})
    options.empty? ? default_connection : SpaceMonkey::Connection.new(options)
  end
end
