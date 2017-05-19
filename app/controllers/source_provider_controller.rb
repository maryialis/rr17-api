class SourceProviderController < ApplicationController
  def version
    render json: {provider: "rr17-api", version: "1"}
  end

  def source_providers
    if params.has_key?(:id)
      render json: SourceProvider.find(params[:id])
    else
      render json: SourceProvider.all
    end
  end
end
