class PlotsController < ApplicationController
  def index
    @plots = Plot.all
  end

  def show
    @plot = Plot.find(params[:id])
  end

  def new
  end

  def create
    Plot.create(plot_params)
    redirect_to '/plots'
  end

  def edit
    @plot = Plot.find(params[:id])
  end

  def update
    plot = Plot.find(params[:id])
    # compact_blank gets rid of fields where nothing was entered before update
    plot.update(plot_params.compact_blank)
    plot.save
    redirect_to "/plots/#{plot.id}"
  end

  private
    def plot_params
      params.permit(:name, :arable, :area_sqft)
    end
end