module SpaceMonkey
  class File < SpaceMonkey::Record
    property :name
    property :content_id
    property :synced

    def exist?
      name && content_id
    end

    alias exists? exist?
  end
end
