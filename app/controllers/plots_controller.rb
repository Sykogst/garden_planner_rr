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
    
  end

  private
    def plot_params
      params.permit(:name, :arable, :area_sqft)
    end
end