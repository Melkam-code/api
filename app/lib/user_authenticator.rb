class UserAuthenticator
  class AuthenticationError < StandardError; end
  def initialize(code)

  end

  def perform
    raise AuthenticationError
  end

  def user
    
  end
end
