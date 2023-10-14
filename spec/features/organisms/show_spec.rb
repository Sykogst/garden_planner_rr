require 'rails_helper'

RSpec.describe 'Organisms show', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
  end

  # User Story 4, Child Show 
  describe 'When user visits /organisms/:id' do
    it 'They see organism with that id including its attributes' do
      visit "organisms/#{@org1.id}"

      expect(page).to have_content(@org1.name)
      expect(page).to have_content("Lives in the : #{@plot1.name}")
      expect(page).to have_content("#{@org1.name} is a plant")
      expect(page).to have_content("Space Taken : #{@org1.max_size_sqft} sq ft")
    end

    it 'They see another organism with another id including its attributes' do
      visit "organisms/#{@org2.id}"

      expect(page).to have_content(@org2.name)
      expect(page).to have_content("Lives in the : #{@plot2.name}")
      expect(page).to have_content("#{@org2.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org2.max_size_sqft} sq ft")
    end
  end

  # User Story 8, Organisms Index Link
  describe 'When a user visits /organisms/:id there is a link to get back to organisms index' do
    it 'They see a link that takes them back to /organisms' do
      visit "organisms/#{@org1.id}"

      expect(page).to have_link('All Organisms', :href=>'/organisms')
    end

    it 'They see a link bar at top of page' do
      visit "organisms/#{@org1.id}"

      expect(page.find('.topBar')).to appear_before(@org1.name)
    end

    it 'Takes user to /organisms after clicking on link' do
      visit "organisms/#{@org1.id}"
      click_on('All Organisms')

      expect(current_path).to eq('/organisms')
    end

    it "Works for another /organisms/:id page with another id " do
      visit "organisms/#{@org2.id}"
      click_on('All Organisms')

      expect(current_path).to eq('/organisms')
    end
  end

  # User Story 9, Parent Index Link
  describe 'When a user visits /organisms/:id there is a link to get back to plots index' do
    it 'They see a link that takes them back to /plots, link bar at top of page' do
      visit "/organisms/#{@org1.id}"

      expect(page).to have_link('All Plots', :href=>'/plots')
      expect(page.find('.topBar')).to appear_before(@org1.name)
    end

    it 'Takes user to /plots after clicking on link' do
      visit "/organisms/#{@org1.id}"
      click_on('All Plots')

      expect(current_path).to eq('/plots')
    end

    it 'Works on another /organisms/:id page with another id' do
      visit "/organisms/#{@org2.id}"
      click_on('All Plots')

      expect(current_path).to eq('/plots')
    end
  end
end