module SpaceMonkey
  class AccountClient < BaseClient
    LoginError = Class.new(StandardError)

    def logged_in?
      @logged_in
    end

    # @return [true]
    # @raise [SpaceMonkey::AccountClient::LoginError] when login fails
    def login(email, password)
      @connection.post('https://accounts.spacemonkey.com/login', email: email, password: password)
      @logged_in = true
    rescue Faraday::ClientError
      raise SpaceMonkey::AccountClient::LoginError, $!
    end

    def info
      response = @connection.get('https://accounts.spacemonkey.com/users/self')
      response.body
    end
  end
end
