class OrganismsController < ApplicationController
  def index
    @organisms = Organism.all
  end

  def show
    @organism = Organism.find(params[:id])
  end

  def edit
    
  end
end