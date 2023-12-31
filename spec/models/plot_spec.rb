require 'rails_helper'

RSpec.describe Plot, type: :model do
  it { should have_many :organisms }

  before(:each) do
    @plot1 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0, created_at: '2020-10-12 [22:22:22]')
    @org1 = @plot1.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 1.0, alive: true)
    @org2 = @plot1.organisms.create!(name: 'Chick', plant: false, max_size_sqft: 5.0, alive: false)
    @org3 = @plot1.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 6.0, alive: true)

    @plot2 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 50.0, created_at: '2023-10-12 [22:22:22]')
    @org4 = @plot2.organisms.create!(name: 'Grass', plant: false, max_size_sqft: 20.0, alive: true)
    @org5 = @plot2.organisms.create!(name: 'Clover', plant: false, max_size_sqft: 20.0, alive: true)

    @plot3 = Plot.create!(name: 'Stable', arable: false, area_sqft: 50.0, created_at: '2019-10-12 [22:22:22]')
    @org6 = @plot3.organisms.create!(name: 'Horse', plant: false, max_size_sqft: 10.0, alive: true)

    @plot4 = Plot.create!(name: 'Stablelike', arable: false, area_sqft: 50.0, created_at: '2024-10-12 [22:22:22]')
  end

  describe '#created_at_order_asc' do
    it 'returns plots in ascending order by created at date' do
      expect(Plot.created_at_order_asc).to eq([@plot3, @plot1, @plot2, @plot4])
    end
  end

  describe '#organisms_count' do
    it 'returns count of organisms on a particular plot' do
      expect(@plot1.organisms_count).to eq(3)
    end
  end

  describe '#sort_by' do
    it 'returns alphebetized list of organisms' do
      expect(@plot1.organisms_sort_by('name')).to eq([@org2, @org1, @org3])
    end
  end

  # Works for a specific plot
  describe '#organisms_size_greater_than' do
    it 'returns list of ones over threshold size' do
      expect(@plot1.organisms_size_greater_than(1.0)).to eq([@org2, @org3])
      expect(@plot1.organisms_size_greater_than(200.0)).to eq([])
    end
  end

  describe '#search_by' do
    it 'Returns matching ones' do
      expect(Plot.search_by('Coop')).to eq([@plot1])
    end

    it 'Returns similar matching ones' do
      expect(Plot.search_by('stable')).to eq([@plot3, @plot4])
    end
  end
end