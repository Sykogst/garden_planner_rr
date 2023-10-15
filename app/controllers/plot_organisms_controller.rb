class PlotOrganismsController < ApplicationController
  before_action :set_plot, only: [:index, :new, :create]
  
  def index
    @organisms = @plot.organisms
  end

  def new
  end

  def create
    @plot.organisms.create(organism_params)
    redirect_to "/plots/#{@plot.id}/organisms"
  end

  private
    def set_plot
      @plot = Plot.find(params[:plot_id])
    end

    def organism_params
      params.permit(:name, :plant, :max_size_sqft, :alive)
    end
end