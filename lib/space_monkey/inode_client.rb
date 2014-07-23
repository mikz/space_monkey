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
      inode(::File.join(ROOT, path), **options)
    end

    class Params
      attr_reader :metadata_only, :network_reads

      def initialize(metadata_only: true, network_reads: false)
        @metadata_only = metadata_only
        @network_reads = network_reads
      end

      def each
        yield :metadata_only, 1 if metadata_only
        yield :network_reads, 1 if network_reads
      end
    end

    private

    def inode(path, **options)
      params = Params.new(options)
      response = @connection.get("inode/#{path}", params)

      Inode::Path.new(response.body).inodes.last
    end
  end
end
