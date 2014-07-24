module SpaceMonkey
  class InodeClient
    ROOT = 'home'

    def initialize(connection)
      @connection = connection
    end

    def home(**options)
      inode(ROOT, **options)
    end

    def path(path, **options)
      inode(::File.join(ROOT, URI.escape(path)), **options)
    end

    private

    def inode(path, **options)
      params = SpaceMonkey::ApiParams.new(options)
      response = @connection.get("inode/#{path}", params)

      Inode::Path.new(response.body).inodes.last
    end
  end
end
