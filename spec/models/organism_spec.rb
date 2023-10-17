require 'rails_helper'

RSpec.describe Organism, type: :model do
  it { should belong_to :plot }

  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0, alive: true)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: true)
    @org3 = @plot2.organisms.create!(name: 'Chick', plant: false, max_size_sqft: 1.0, alive: false)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 6.0, alive: true)
    @org5 = @plot2.organisms.create!(name: 'Chick', plant: false, max_size_sqft: 1.0, alive: true)
  end

  describe '#alive_all_true' do
    it 'returns list of true only' do
      expect(Organism.alive_true_all.count).to eq(4)
    end
  end

  # This works for filtering ALL organisms, not per specific plot
  describe '#size_greater_than' do
    it 'returns list of ones over threshold size' do
      expect(Organism.size_greater_than(2.0)).to eq([@org1, @org2, @org4])
      expect(Organism.size_greater_than(200.0)).to eq([])
    end
  end

  describe '#search_by' do
    it 'Returns matching ones' do
      expect(Organism.search_by('Chicken')).to eq([@org2])
    end

    it 'Returns similar matching ones' do
      expect(Organism.search_by('chick')).to eq([@org2, @org3, @org5])
    end
  end
end