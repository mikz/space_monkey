module SpaceMonkey
  class Share < SpaceMonkey::Record
    # @!attribute filename
    #   @return [String]
    property :filename

    # @!attribute path
    #   @return [String]
    property :path

    # @!attribute type
    #   @return [String]
    property :type

    # @!attribute sharetype
    #   @return [String]
    property :sharetype

    # @!attribute share_id
    #   @return [String]
    property :share_id

    # @!attribute share_name
    #   @return [String]
    property :share_name

    # @return [URI::HTTPS]
    def link
      link = url
      link.path = link.path + '.html'
      link
    end

    # @return [URI::HTTPS]
    def url
      URI.join('https://beta.spacemonkey.com/shares/', share_id, filename)
    end
  end
end
