require 'forwardable'

module SpaceMonkey
  class Inode
    attr_reader :inode, :parent, :content_id

    FILE = 'FILE'.freeze
    DIR = 'DIR'.freeze

    ROOT = 'home'.freeze
    CONTENT_ID = 'content_id'.freeze
    INODE = 'inode'.freeze

    # @param content_id [String]
    # @param inode [Hash,#fetch]
    # @param parent [Inode,nil]
    def initialize(content_id, inode, parent)
      @content_id = content_id
      @inode = inode
      @parent = parent
    end

    # @return [String]
    def name
      @parent ? @parent.name_of(content_id) : ROOT
    end

    # @return [String,nil]
    def name_of(content_id)
      found = @inode.fetch('dir_ents').find{|ent| ent[CONTENT_ID] == content_id }
      found && found['name']
    end

    # @return [Array<SpaceMonkey::File,SpaceMonkey::Folder>]
    def entries
      # TODO: mutex
      @entries ||= @inode.fetch('dir_ents').map { |entry| build_entry(entry) }
    end

    private

    def build_entry(entry)
      klass = case type = entry.fetch('type')
                when FILE then SpaceMonkey::File
                when DIR then SpaceMonkey::Folder
                else raise "Unknown type #{type}"
              end
      klass.new(entry)
    end

    class Path
      extend Forwardable
      def_delegators :@inodes, :last, :first, :each

      INODES = 'inodes'.freeze

      # @return [Array<Inode>]
      attr_reader :inodes

      # @param response [Hash, #fetch]

      def initialize(response)
        last = nil

        @inodes = response.fetch(INODES).map do |node|
          last = Inode.new(node.fetch(CONTENT_ID), node.fetch(INODE), last)
        end
      end

      # @return [String] full path of all inodes
      def to_s
        ::File.join(*@inodes.map(&:name))
      end
    end
  end
end
