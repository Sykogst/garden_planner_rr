class PlotsController < ApplicationController
  before_action :set_plot, only: [:show, :edit, :update]

  def index
    @plots = Plot.created_at_order_asc
    if params[:search_name]
      @plots = Plot.search_by(params[:search_name])
    end
  end

  def show
  end

  def new
  end

  def create
    Plot.create(plot_params)
    redirect_to '/plots'
  end

  def edit
  end

  def update
    # compact_blank gets rid of fields where nothing was entered before update
    @plot.update(plot_params.compact_blank)
    @plot.save  # Not required
    redirect_to "/plots/#{@plot.id}"
  end

  def destroy
    Plot.destroy(params[:id])
    redirect_to '/plots'
  end

  private
    def set_plot
      @plot = Plot.find(params[:id])
    end

    def plot_params
      params.permit(:name, :arable, :area_sqft)
    end
end