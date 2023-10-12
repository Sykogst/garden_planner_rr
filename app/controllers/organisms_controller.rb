class OrganismsController < ApplicationController
  def index
    @organisms = Organism.all
  end
end