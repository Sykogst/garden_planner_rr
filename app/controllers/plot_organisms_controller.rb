class PlotOrganismsController < ApplicationController
  def index
    @plot = Plot.find(params[:plot_id])
    @organisms = @plot.organisms
  end

  def new
    @plot = Plot.find(params[:plot_id])
  end

  def create
    plot = Plot.find(params[:plot_id])
    plot.organisms.create(organism_params)
    redirect_to "/plots/#{plot.id}/organisms"
  end

  private
    def organism_params
      params.permit(:name, :plant, :max_size_sqft)
    end
end