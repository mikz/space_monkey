require 'forwardable'

module SpaceMonkey
  class Inode
    attr_reader :inode, :parent, :content_id

    ROOT = 'home'.freeze
    CONTENT_ID = 'content_id'.freeze
    INODE = 'inode'.freeze

    def initialize(content_id, inode, parent)
      @content_id = content_id
      @inode = inode
      @parent = parent
    end

    def name
      @parent ? @parent.name_of(content_id) : ROOT
    end

    def name_of(content_id)
      puts @inode.inspect
      found = @inode.fetch('dir_ents').find{|ent| ent[CONTENT_ID] == content_id }
      found && found['name']
    end

    class Path
      extend Forwardable
      def_delegators :@inodes, :last, :first, :each

      INODES = 'inodes'.freeze

      attr_reader :inodes

      def initialize(response)
        last = nil

        @inodes = response.fetch(INODES).map do |node|
          last = Inode.new(node.fetch(CONTENT_ID), node.fetch(INODE), last)
        end
      end

      def to_s
        ::File.join(*@inodes.map(&:name))
      end
    end
  end
end
