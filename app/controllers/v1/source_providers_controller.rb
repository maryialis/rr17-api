module V1

  class SourceProvidersController < ApiBaseController
    before_action :authenticate, only: [:create, :update, :destroy]
    def home
      render json: {provider: "rr17-api", version: "1"}
    end

    def index
      render json: SourceProvider.where(active: true)
    end
    
    def create
      rec = SourceProvider.new(source_provider_params)
      rec.user_id ||= current_user.id
      if rec.user_id == current_user.id
        if rec.save
          render json: rec
        else
          render json: {errors: rec.errors, status: 400}, status: 400
        end
      else
        render json: {errors: "Unauthorized to create source provider", status: 401}, status: 401
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
      if (rec.user_id == current_user.id)
        rec.assign_attributes(source_provider_params)
        if rec.save
          render json: rec
        else
          render json: {errors: rec.errors, status: 400}, status: 400
        end
      else
        render json: {errors: "Unauthorized to update source provider", status: 401}, status: 401
      end
    end
    
    def destroy
      rec = SourceProvider.find_by_id(params[:id])
      if rec
        if rec.user_id == current_user.id
          rec.destroy
        else
          render json: {errors: "Unauthorized to destroy source provider", status: 401}, status: 401
        end
      end
    end
    
    def parse_now
      rec = SourceProvider.where(id: params[:id], active: true)
      if rec.empty?
        render json: {errors: "Source provider not found", status: 400}, status: 400
      else
        spr = rec[0]
        render json: SourceParser.parse_source_provider(spr)
      end
      rescue StandardError => e
        render json: {errors: e.message, status: 400}, status: 400
    end
    
    def parse_all
      SourceProvider.where(active: true).each do |spr|
        ApplicationJob.perform_later(spr)
      end
      render json: {scheduled: Time.now, status: 203}, status: 203
      rescue StandardError => e
        render json: {errors: e.message, status: 400}, status: 400
    end
    
    private
    
    def source_provider_params
      params.require(:source_provider).permit(:name, :url, :address, :active, :user_id)
    end
  end

end
