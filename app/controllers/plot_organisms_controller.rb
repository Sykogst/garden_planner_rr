class PlotOrganismsController < ApplicationController
  before_action :set_plot, only: [:index, :new, :create]
  
  def index
    # ONly one instance variable
    # Already sending plot
    # Moke methods on the plot
    @organisms = @plot.organisms_sort_by(params[:sort_abc])
    if params[:threshold]
      @organisms = @plot.organisms_size_greater_than(params[:threshold])
    end
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