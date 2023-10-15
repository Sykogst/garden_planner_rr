require 'rails_helper'

RSpec.describe Plot, type: :model do
  it { should have_many :organisms }

  before(:each) do
    @plot1 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0, created_at: '2020-10-12 [22:22:22]')
    @org1 = @plot1.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: true)
    @org2 = @plot1.organisms.create!(name: 'Chick', plant: false, max_size_sqft: 5.0, alive: false)
    @org3 = @plot1.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0, alive: true)

    @plot2 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 50.0, created_at: '2023-10-12 [22:22:22]')
    @plot3 = Plot.create!(name: 'Stable', arable: false, area_sqft: 50.0, created_at: '2019-10-12 [22:22:22]')
  end

  describe '#created_at_order_asc' do
    it 'returns plots in ascending order by created at date' do
      expect(Plot.created_at_order_asc).to eq([@plot3, @plot1, @plot2])
    end
  end

  describe '#organisms_count' do
    it 'returns count of organisms on a particular plot' do
      expect(@plot1.organisms_count).to eq(3)
    end
  end

  describe '#sort_alphabetical' do
  it 'returns' do
    expect(@plot1.sort_alphabetical).to eq[@org2, @org1, @org3]
  end
end
end