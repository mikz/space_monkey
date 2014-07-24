module SpaceMonkey
  class File < SpaceMonkey::Record
    # @!attribute name
    #   @return [String]
    property :name
    # @!attribute content_id
    #   @return [String]
    property :content_id
    # @!attribute synced
    #   @return [Boolean]
    property :synced

    # @return [Boolean]
    def exist?
      name && content_id
    end

    alias exists? exist?
  end
end
