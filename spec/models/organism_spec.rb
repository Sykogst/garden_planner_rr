require 'rails_helper'

RSpec.describe Organism, type: :model do
  it { should belong_to :plot }

  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0, alive: true)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: true)
    @org3 = @plot2.organisms.create!(name: 'Chick', plant: false, max_size_sqft: 5.0, alive: false)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0, alive: true)
  end

  describe '#alive_all_true' do
    it 'returns list of true only' do
      expect(Organism.alive_true_all.count).to eq(3)
    end
  end
end