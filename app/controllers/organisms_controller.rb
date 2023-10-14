class OrganismsController < ApplicationController
  def index
    @organisms = Organism.all
  end

  def show
    @organism = Organism.find(params[:id])
  end

  def edit
    @organism = Organism.find(params[:id])
  end

  def update
    organism = Organism.find(params[:id])
    organism.update(organism_params.compact_blank)
    organism.save
    redirect_to "/organisms/#{organism.id}"
  end

  private
    def organism_params
      params.permit(:name, :plant, :max_size_sqft)
    end
end