module V1

class ApiBaseController < ApplicationController
  
  def logged_in?
   !!current_user
  end
  
  def current_user
    if auth_present?
      user = User.where(email: auth['email'], password: auth['password'])
      if user
        @current_user ||= user
      end
    end
  end
  
  def authenticate
    unless logged_in?
      render json: {errors: "unauthorized", status: 401}, status: 401 
    end
  end
  
  private
  def token
    request.env["HTTP_AUTHORIZATION"].scan(/Bearer (.*)$/).flatten.last
  end
  
  def auth
    Auth.new(Rails.application.secrets.secret_key_base).decode(token)
  end
  
  def auth_present?
    !!request.env.fetch("HTTP_AUTHORIZATION", "").scan(/Bearer/).flatten.first
  end
end

end
