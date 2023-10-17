class OrganismsController < ApplicationController
  before_action :set_organism, only: [:show, :edit, :update]

  def index
    @organisms = Organism.alive_true_all
  end

  def show
  end

  def edit
  end

  def update
    @organism.update(organism_params.compact_blank)
    @organism.save
    redirect_to "/organisms/#{@organism.id}"
  end

  def destroy
    Organism.destroy(params[:id])
    redirect_to '/organisms'
  end

  private
    def set_organism
      @organism = Organism.find(params[:id])
    end

    def organism_params
      params.permit(:name, :plant, :max_size_sqft, :alive)
    end
end