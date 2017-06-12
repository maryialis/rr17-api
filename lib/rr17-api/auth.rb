require 'jwt'
class Auth
  ALGORITHM = 'HS256'
  
  
  def initialize(auth_secret)
    @auth_secret = auth_secret
  end
  
  def issue(payload)
    JWT.encode(payload, @auth_secret, ALGORITHM)
  end
  
  def decode(token)
      JWT.decode(token, @auth_secret, true, { algorithm: ALGORITHM }).first
  end
  
  #def self.auth_secret
  #  Rails.application.secrets.secret_key_base
  #end
end  
