module SpaceMonkey
  class FileClient

    def initialize(connection)
      @connection = connection
    end

    def new(**options)
      SpaceMonkey::File.new(options)
    end

    def download(inode)
      @connection.get("file/#{inode.content_id}:/#{inode.name}")
    end
  end
end
