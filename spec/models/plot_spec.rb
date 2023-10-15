require 'rails_helper'

RSpec.describe Plot, type: :model do
  it { should have_many :organisms }

  describe '#organisms_count' do
    it 'returns count of organisms on a particular plot' do
      plot = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
      org1 = plot.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: true)
      org2 = plot.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: false)
      org3 = plot.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0, alive: true)

      expect(plot.organisms_count).to eq(3)
    end
  end
end