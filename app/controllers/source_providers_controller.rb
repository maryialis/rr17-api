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
  
  def parse_now
    rec = SourceProvider.where(id: params[:id], active: true)
    if rec.empty?
      render json: {errors: "Source provider not found", status: 400}, status: 400
    else
      spr = rec[0]
      sp = SourceParser.source_parser_from_source_provider(spr)
      if sp
        parser_class = "Parser::#{SourceParser.source_parser_from_source_provider(spr)}".constantize rescue nil
        if (parser_class)
          parser = parser_class.new
          result = parser.parse(File.open('/home/masha/RoR/rr17-api/test/belarusbank.html', encoding: 'windows-1251:utf-8').read).as_json
          if result["parsed"]
            cr = CourseResult.new(result['result']);
            cr[:source_provider_id] = spr.id
            if cr.save
              render json: result
            else
              render json: {errors: cr.errors, status: 400}, status: 400
            end
          else
            render json: {errors: "#{result['error']}", status: 400}, status: 400
          end
        else
          render json: {errors: "Appropriate parser not found", status: 400}, status: 400
        end
      else
        render json: {errors: "Appropriate parser not found", status: 400}, status: 400
      end
    end
  end
  
  private
  def source_provider_params
    params.require(:source_provider).permit(:name, :url, :address, :active, :user_id)
  end
end
