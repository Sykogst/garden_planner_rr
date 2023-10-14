require 'rails_helper'

RSpec.describe 'Plots edit', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org3 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0)
  end
  
  # User Story 12, Plot Update 
  describe 'When a user visits /plots/id there is a link to update this record' do
    it 'They see a link /plots/new to update current plot record, New Plot' do
      visit "/plots/#{@plot1.id}"

      expect(page).to have_link('Update Plot', :href=>"/plots/#{@plot1.id}/edit")
    end

    it 'Takes user to /plots/:plot_id/edit after clicking on link' do
      visit "/plots/#{@plot1.id}"
      click_on('Update Plot')

      expect(page).to have_content("Update #{@plot1.name}")
      expect(current_path).to eq("/plots/#{@plot1.id}/edit")
    end

    it 'User fills in form for plot with proper attributes, hit button Submit Update, then redirects back to /plots with updates' do
      visit "/plots/#{@plot1.id}/edit"

      # Only update one field in form, rest are blank and desired to stay the same
      fill_in('name', with: 'Pumpkin Patch')
      click_on('Submit')

      expect(current_path).to eq("/plots/#{@plot1.id}")
      # Test to see that form did not update this attribute, as nothing was entered
      expect(page).to have_content("Total Area : 100.0 sq ft")
    end
  end
end