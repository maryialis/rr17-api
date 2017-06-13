module V1
  class SessionsController < ApiBaseController
    skip_before_action :authenticate, raise: false
    def create
      user = User.find_by(email: auth_params[:email])
      render json: { errors: 'Unauthorized to create source provider', status: 401 }, status: 401 && return unless user.password == auth_params[:password]
      jwt = Auth.new(Rails.application.secrets.secret_key_base).issue(email: auth_params[:email], password: auth_params[:password])
      render json: { jwt: jwt }
    end

    private

    def auth_params
      params.require(:auth).permit(:email, :password)
    end
  end
end
