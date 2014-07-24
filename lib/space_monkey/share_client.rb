module SpaceMonkey
  class ShareClient < BaseClient
    def file(path)
      response = @connection.post("shares/path/#{URI.escape(path)}")
      SpaceMonkey::Share.new(response.body)
    end
  end
end
