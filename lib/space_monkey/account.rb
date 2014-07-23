module SpaceMonkey
  class Account
    attr_accessor :connection

    LoginError = Class.new(StandardError)

    def initialize(connection)
      @connection = connection
    end

    def logged_in?
      @logged_in
    end

    def login(email, password)
      response = @connection.post('https://accounts.spacemonkey.com/login', email: email, password: password)
      raise LoginError, response.status unless response.success?
      @logged_in = true
    end

    def info
      response = @connection.get('https://accounts.spacemonkey.com/users/self')
      response.body
    end
  end
end
