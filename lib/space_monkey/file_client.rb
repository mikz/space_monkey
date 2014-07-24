module SpaceMonkey
  class FileClient
    NonExistingFile = Class.new(StandardError)

    def initialize(connection)
      @connection = connection
    end

    def new(**options, &block)
      SpaceMonkey::File.new(options, &block)
    end

    def download(file, **options)
      raise NonExistingFile, "File is not valid" unless file.exists?
      response = @connection.get("file/#{file.content_id}:/#{URI.escape(file.name)}", params(options))
      response.body
    end

    def thumbnail(file, **options)
      raise NonExistingFile, "File is not valid" unless file.exists?
      response = @connection.get("thumbnail/#{file.content_id}:/#{URI.escape(file.name)}", params(options))
      response.body
    end

    def upload(file, inode, io)
      response = @connection.put do |req|
        req.url "file/#{inode.content_id}/#{URI.escape(file.name)}"
        req.headers['Content-Type'] = 'application/octet-stream'
        req.headers['Content-Length'] = io.size.to_s
        req.body = io
      end

      file.merge!(response.body)
    end

    def delete(file, inode = parent)
      response = @connection.delete("inode/#{inode.content_id}:/#{URI.escape(file.name)}", content_id: file.content_id)
      response.body
    end

    private

    def params(options)
      SpaceMonkey::ApiParams.new(options)
    end
  end
end
