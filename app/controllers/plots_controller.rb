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
    Plot.create(name: params[:name], arable: params[:arable], area_sqft: params[:area_sqft])
    redirect_to '/plots'
  end
end