module SpaceMonkey
  class Share < SpaceMonkey::Record
    property :filename
    property :path
    property :type
    property :sharetype
    property :share_id
    property :share_name

    def link
      link = url
      link.path = link.path + '.html'
      link
    end

    def url
      URI.join('https://beta.spacemonkey.com/shares/', share_id, filename)
    end
  end
end
