class UserController < ApplicationController
  def index
    render json: User.all
  end
  
  def show
    render json: User.find(params[:id])
  end
  
  def create
    User.create!(JSON.parse(request.body.read))
    rescue ActiveRecord::RecordInvalid => invalid
      render json: {errors: invalid.record.errors, status: 400}, status: 400
  end
end
