require 'delayed_job'

module V1

  class SourceProvidersController < ApiBaseController
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
        parser = instantiate_parser(spr)
        if (parser)
          render json: SourceProvidersController.parse_and_process(parser, spr)
        else
          render json: {errors: "Appropriate parser not found", status: 400}, status: 400
        end
      end
    end
    
    def parse_all
      SourceProvider.where(active: true).each do |spr|
        parser = instantiate_parser(spr)
        SourceProvidersController.delay.parse_and_process(parser, spr) if parser
      end
      render json: {scheduled: Time.now, status: 203}, status: 203
      rescue StandardError => e
        render json: {errors: e.message, status: 400}, status: 400
        return
    end
    
    private
    def instantiate_parser(source_provider)
      sp = SourceParser.source_parser_by_source_provider(source_provider)
      parser_class = "Parser::#{sp}".constantize rescue nil if sp
      if (parser_class)
        parser_class.new
      else
        nil
      end
    end
    
    def self.parse_and_process(parser, spr)
      result = parser.parse(File.open('/home/masha/RoR/rr17-api/test/belarusbank.html', encoding: 'windows-1251:utf-8').read).as_json
      if result["parsed"]
        cr = CourseResult.new(result['result']);
        cr[:source_provider_id] = spr.id
        if cr.save
          return result
        else
          return {errors: cr.errors, status: 400}, status: 400
        end
      else
        return {errors: "#{result['error']}", status: 400}, status: 400
      end
    end
    
    def source_provider_params
      params.require(:source_provider).permit(:name, :url, :address, :active, :user_id)
    end
  end

end
