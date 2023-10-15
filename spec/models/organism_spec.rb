require 'rails_helper'

RSpec.describe Organism, type: :model do
  it { should belong_to :plot }

  describe '#only_alive' do
    it 'returns list of true only' do
      plot = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
      org1 = plot.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: true)
      org2 = plot.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: false)
      org3 = plot.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0, alive: true)

      plot2 = Plot.create!(name: 'Lawn', arable: false, area_sqft: 50.0)
      org4 = plot.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 5.0, alive: true)

      expect(Organism.only_alive.count).to eq(3)
    end
  end
end