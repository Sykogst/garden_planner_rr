require 'rails_helper'

RSpec.describe 'Plots new', type: :feature do
  before(:each) do
    old_date = '2022-10-12 [22:22:22]'
    oldest_date = '2021-10-12'
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0, created_at: oldest_date)
    @plot3 = Plot.create!(name: 'Flower Bed', arable: true, area_sqft: 10.0, created_at: old_date)
  end
  
  # User Story 11, Plot Creation 
  describe 'When a user visits /plots there is a link to create a new record' do
    it 'They see a link /plots/new to create a new plot record, New Plot' do
      visit '/plots'

      expect(page).to have_link('New Plot', :href=>'/plots/new')
    end

    it 'Takes user to /plots/new after clicking on link' do
      visit '/plots'
      click_on('New Plot')

      expect(page).to have_content("New Plot")
      expect(current_path).to eq('/plots/new')
    end

    it 'User fills in form for plot with proper attributes, hit button Create Plot, then redirects back to /plots with new plot' do
      visit '/plots/new'

      fill_in('name', with: 'Vegetable Patch')
      fill_in('arable', with: true)
      fill_in('area_sqft', with: 20.0)
      click_on('Create Plot')

      expect(current_path).to eq('/plots')
      expect(page).to have_content('Vegetable Patch')
    end
  end
end