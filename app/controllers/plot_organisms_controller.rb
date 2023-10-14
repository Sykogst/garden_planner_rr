class PlotOrganismsController < ApplicationController
  def index
    @plot = Plot.find(params[:plot_id])
    @organisms = @plot.organisms
  end

  def new
  end
end