module SpaceMonkey
  class InodeClient < BaseClient
    ROOT = 'home'

    # @param options [ApiParams]
    # @return [Inode]
    def home(**options)
      inode(ROOT, **options)
    end

    # @param options [ApiParams]
    # @param path [String]
    # @return [Inode]
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
