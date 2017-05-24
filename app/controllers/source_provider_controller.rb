class SourceProviderController < ApplicationController
  def version
    render json: {provider: "rr17-api", version: "1"}
  end

  def index
    render json: SourceProvider.all
  end
  
  def show
    render json: SourceProvider.find(params[:id])
  end
end
