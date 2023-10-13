require 'rails_helper'

RSpec.describe 'Organisms index', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org3 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0)
  end

  # User Story 3, Organism Index 
  describe 'When a user visits /organisms' do
    it 'They see each organism in the system including its attributes' do
      visit '/organisms'

      expect(page).to have_content('Things Living in the Garden')
      expect(page).to have_content(@org1.name)
      expect(page).to have_content("#{@org1.name} is a plant")
      expect(page).to have_content("Space Taken : #{@org1.max_size_sqft} sq ft")
      expect(page).to have_content(@org2.name)
      expect(page).to have_content("#{@org2.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org2.max_size_sqft} sq ft")
      expect(page).to have_content(@org3.name)
      expect(page).to have_content("#{@org3.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org3.max_size_sqft} sq ft")
      expect(page).to have_content(@org4.name)
      expect(page).to have_content("#{@org4.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org4.max_size_sqft} sq ft")
    end
  end
end