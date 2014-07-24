module SpaceMonkey
  class FileClient < BaseClient
    NonExistingFile = Class.new(StandardError)

    # @return [SpaceMonkey::File] a new file
    def new(**options, &block)
      SpaceMonkey::File.new(options, &block)
    end

    # @param options [ApiParams]
    # @return [String] binary blob
    # @raise [NonExistingFile] when file does not exist
    def download(file, **options)
      raise NonExistingFile, "File is not valid" unless file.exists?
      response = @connection.get("file/#{file.content_id}:/#{URI.escape(file.name)}", params(options))
      response.body
    end

    # @param options [ApiParams]
    # @return [String] binary blob
    # @raise [NonExistingFile] when file does not exist
    def thumbnail(file, **options)
      raise NonExistingFile, "File is not valid" unless file.exists?
      response = @connection.get("thumbnail/#{file.content_id}:/#{URI.escape(file.name)}", params(options))
      response.body
    end

    # @param file [SpaceMonkey::File] a file with name
    # @param inode [SpaceMonkey::Inode,#content_id] an inode with content_id
    # @param io [#size] any IO which has #size
    # @return [SpaceMonkey::File] same file as passed merged with results of upload

    def upload(file, inode, io)
      response = @connection.put do |req|
        req.url "file/#{inode.content_id}/#{URI.escape(file.name)}"
        req.headers['Content-Type'] = 'application/octet-stream'
        req.headers['Content-Length'] = io.size.to_s
        req.body = io
      end

      file.merge!(response.body)
    end

    # @param file [SpaceMonkey::File] a file with name
    # @param inode [SpaceMonkey::Inode,#content_id] an inode with content_id

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
