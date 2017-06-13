require 'jwt'
# authorization
class Auth
  ALGORITHM = 'HS256'.freeze

  def initialize(auth_secret)
    @auth_secret = auth_secret
  end

  def issue(payload)
    JWT.encode(payload, @auth_secret, ALGORITHM)
  end

  def decode(token)
    JWT.decode(token, @auth_secret, true, algorithm: ALGORITHM).first
  end
end
