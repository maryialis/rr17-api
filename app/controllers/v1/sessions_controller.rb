module V1
  class SessionsController < ApiBaseController
    skip_before_action :authenticate, raise: false
    def create
      user = User.find_by(email: auth_params[:email])
      if (user.password == auth_params[:password])
        jwt = Auth.new(Rails.application.secrets.secret_key_base).issue({ :email => auth_params[:email], :password => auth_params[:password] })
        render json: {jwt: jwt}
      else
      end
    end

    private
    def auth_params
      params.require(:auth).permit(:email, :password)
    end
  end
end
