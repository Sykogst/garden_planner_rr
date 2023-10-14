require 'rails_helper'

RSpec.describe 'Plot Organism new', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org3 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0)
  end

  # User Story 13, Plot Organism Creation 
  describe 'When a user visits /plots/:plot_id/organisms there is a link to create a new record' do
    it 'They see a link /plots/:plot_id/organisms/new to create a new organism record, New Organism' do
      visit "/plots/#{@plot1.id}/organisms"

      expect(page).to have_link('New Organism', :href=>"/plots/#{@plot1.id}/organisms/new")
    end

    it 'Takes user to /plots/new after clicking on link' do
      visit "/plots/#{@plot1.id}/organisms"
      click_on('New Organism')

      expect(page).to have_content("New Organism")
      expect(current_path).to eq("/plots/#{@plot1.id}/organisms/new")
    end

    xit 'User fills in form for plot with proper attributes, hit button Add Organism, then redirects back to /plots with new plot' do
      visit "/plots/#{@plot1.id}/organisms/new"

      fill_in('name', with: 'Grass')
      fill_in('plant', with: true)
      fill_in('max_size_sqft', with: 20.0)
      click_on('Add Organism')

      expect(current_path).to eq("/plots/#{@plot1.id}/organisms")
      expect(page).to have_content('Grass')
      expect(@plot1.organisms_count).to eq(2)
    end
  end
end