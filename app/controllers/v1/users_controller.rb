module V1

  class UsersController < ApiBaseController
    before_action :authenticate, only: [:create, :update, :destroy]
    def index
      render json: User.all
    end
    
    def create
      rec = User.create(user_params)
      if rec.valid?
        render json: rec
      else
        render json: {errors: rec.errors, status: 400}, status: 400
      end
    end
    
    def show
      rec = User.find_by_id(params[:id])
      if rec
        render json: rec
      else
        render json: {errors: "User not found", status: 400}, status: 400
      end
    end
    
    def update
      rec = User.find_by_id(params[:id])
      if rec
        rec.update(user_params)
        if rec.valid?
          render json: rec
        else
          render json: {errors: rec.errors, status: 400}, status: 400
        end
      else
        render json: {errors: "User not found", status: 400}, status: 400
      end
    end
    
    def destroy
      rec = User.find_by_id(params[:id])
      rec.destroy if rec
    end
    
    private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
  end

end
