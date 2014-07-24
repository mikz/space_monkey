require 'hashie/trash'

module SpaceMonkey
  class ApiParams < Hashie::Trash
    TO_INTEGER = ->(v) { v ? 1 : 0 }

    # @!attribute network_reads
    #   @return [0,1,nil]
    property :network_reads, transform_with: TO_INTEGER

    # @!attribute metadata_only
    #   @return [0,1]
    property :metadata_only, default: true, transform_with: TO_INTEGER

    # @!attribute generation_id
    #   @return [Integer,nil]
    property :generation_id
  end
end
