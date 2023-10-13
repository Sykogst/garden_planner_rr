require 'rails_helper'

RSpec.describe 'Plots show', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
  end

  # User Story 2, Plots Show 
  describe 'When a user visits /plots/:id' do
    it 'They see the plot with that id including its attributes' do
      visit "plots/#{@plot1.id}"

      expect(page).to have_content(@plot1.name)
      expect(page).to have_content("Contains : plants")
      expect(page).to have_content("Total Area : #{@plot1.area_sqft} sq ft")
    end

    it 'They see a different plot with another id including its attributes' do
      visit "plots/#{@plot2.id}"

      expect(page).to have_content(@plot2.name)
      expect(page).to have_content("Contains : animals")
      expect(page).to have_content("Total Area : #{@plot2.area_sqft} sq ft")
    end
  end

  # User Story 7, Parent Child Count
  describe 'When a user visits /plots/:id' do
    before(:each) do
      @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0)
      @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
      @org3 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
      @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0)
    end

    it 'They see the plot with that id including count of organisms' do
      visit "plots/#{@plot1.id}"

      expect(@plot1.organism_count).to eq(1)
      expect(page).to have_content("Organism Count : #{@plot1.organism_count}")
    end

    it 'They see a different plot with another count of organisms' do
      visit "plots/#{@plot2.id}"

      expect(@plot2.organism_count).to eq(3)
      expect(page).to have_content("Organism Count : #{@plot2.organism_count}")
    end
  end
end