require 'forwardable'

module SpaceMonkey
  class Inode
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

    class Path
      extend Forwardable
      def_delegators :@inodes, :last, :first, :each

      INODES = 'inodes'.freeze

      def initialize(response)
        @inodes = response.fetch(INODES).map{ |node| class_for(node).new(node) }
      end

      private

      def class_for(node)
        case node['inode']['metadata']['type']
          when 'DIR'
            Inode::Directory
          when 'FILE'
            Inode::File
        end
      end
    end

    class Content
      CONTENT_ID = 'content_id'.freeze
      METADATA = 'metadata'.freeze
      INODE = 'inode'.freeze

      attr_reader :content_id, :metadata

      def initialize(content)
        @content_id = content.fetch(CONTENT_ID)
        @inode = content.fetch(INODE)
        @metadata = @inode.fetch(METADATA)
      end
    end

    class Directory < Content
      DIR_ENTS = 'dir_ents'.freeze

      attr_reader :entries

      Entry = Struct.new(:name, :content_id, :synced)
      EntryMembers = Entry.members.map(&:to_s)

      def initialize(content)
        super
        @entries = @inode.fetch(DIR_ENTS).map { |entry| Entry.new(*entry.values_at(*EntryMembers)) }
      end
    end

    class File < Content

    end

    private

    def inode(path, **options)
      params = Params.new(options)
      response = @connection.get("inode/#{path}", params)
      puts response.body.inspect
      Path.new(response.body)
    end
  end
end
