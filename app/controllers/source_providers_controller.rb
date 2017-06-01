class SourceProvidersController < ApplicationController
  def home
    render json: {provider: "rr17-api", version: "1"}
  end

  def index
    render json: SourceProvider.where(active: true)
  end
  
  def create
    rec = SourceProvider.new(source_provider_params)
    if rec.save
      render json: rec
    else
      render json: {errors: rec.errors, status: 400}, status: 400
    end
  end
  
  def show
    rec = SourceProvider.find_by_id(params[:id])
    if (rec && rec.active)
      render json: rec
    else
      render json: {errors: "Source provider not found", status: 400}, status: 400
    end
  end
  
  def update
    rec = SourceProvider.find_by_id(params[:id])
    rec.assign_attributes(source_provider_params)
    if rec.save
      render json: rec
    else
      render json: {errors: rec.errors, status: 400}, status: 400
    end
  end
  
  def destroy
    rec = SourceProvider.find_by_id(params[:id])
    rec.destroy if rec
  end
  
  private
  def source_provider_params
    params.require(:source_provider).permit(:name, :url, :address, :active, :user_id)
  end
end
