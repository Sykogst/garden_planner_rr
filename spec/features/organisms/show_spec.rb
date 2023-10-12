require 'rails_helper'

RSpec.describe 'Organisms show', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org3 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0)
  end

  # User Story 4, Child Show 
  describe 'When user visits /organisms/:id' do
    it 'They see organism with that id of 1 including its attributes' do
      visit "organisms/#{@org1.id}"
      
      expect(page).to have_content(@org1.name)
      expect(page).to have_content("Lives in the : #{@org1.plot_1.name}")
      expect(page).to have_content("#{@org1.name} is a plant")
      expect(page).to have_content("Space Taken : #{@org1.max_size_sqft} sq ft")
    end

    it 'They see organism with that id of 2 including its attributes' do
      visit "organisms/#{@org1.id}"

      expect(page).to have_content(@org2.name)
      expect(page).to have_content("Lives in the : #{@org2.plot_1.name}")
      expect(page).to have_content("#{@org2.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org2.max_size_sqft} sq ft")
    end
  end
end