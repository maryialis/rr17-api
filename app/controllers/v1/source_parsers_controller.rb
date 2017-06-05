module V1
  
  class SourceParsersController < ApiBaseController
    before_action :authenticate, only: [:create, :update, :destroy]
    def index
      render json: SourceParser.all
    end

    def show
      render json: params
      #rec = SourceParser.find_by_id(params[:id])
      #if rec
      #  render json: rec
      #else
      #  render json: {errors: "SourceParser not found", status: 400}, status: 400
     #end
    end

    def create
      rec = SourceParser.create(source_parser_params)
      if rec.valid?
        render json: rec
      else
        render json: {errors: rec.errors, status: 400}, status: 400
      end
    end

    def destroy
      rec = SourceParser.find_by_id(params[:id])
      rec.destroy if rec
    end

    def update
      rec = SourceParser.find_by_id(params[:id])
      if rec
        rec.update(source_parser_params)
        if rec.valid?
          render json: rec
        else
          render json: {errors: rec.errors, status: 400}, status: 400
        end
      else
        render json: {errors: "SourceParser not found", status: 400}, status: 400
      end
    end
    
    private
    def source_parser_params
      params.require(:source_parser).permit(:parser_name, :url_pattern)
    end
  end

end
