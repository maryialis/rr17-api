class SourceProviderController < ApplicationController
  def version
    render json: {provider: "rr17-api", version: "1"}
  end

  def index
    render json: SourceProvider.where(active: true)
  end
  
  def show
    rec = SourceProvider.find_by_id(params[:id])
    if (rec && rec.active)
      render json: rec
    else
      render plain: "Record not found"
    end
  end
end
