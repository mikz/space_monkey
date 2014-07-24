require 'hashie/trash'

module SpaceMonkey
  class ApiParams < Hashie::Trash
    TO_INTEGER = ->(v) { v ? 1 : 0 }

    property :network_reads, transform_with: TO_INTEGER
    property :metadata_only, default: true, transform_with: TO_INTEGER
  end
end
