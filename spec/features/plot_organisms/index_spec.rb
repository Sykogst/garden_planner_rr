require 'rails_helper'

RSpec.describe 'Plot Organisms index', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0, alive: true)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: true)
    @org3 = @plot2.organisms.create!(name: 'Chick', plant: false, max_size_sqft: 5.0, alive: false)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0, alive: true)
  end

  # User Story 5, Plot Organism Index 
  describe 'When a user visits /plots/:plot_id/organisms' do
    it 'Then they see each organism and its attributes that is associated with that plot id' do
      visit "/plots/#{@plot1.id}/organisms"

      expect(page).to have_content(@plot1.name)
      expect(page).to have_content("#{@org1.name} is a plant")
      expect(page).to have_content("Space Taken : #{@org1.max_size_sqft} sq ft")
      expect(page).to have_content("Alive : Yes")
    end

    it 'Then they see each organism and its attributes that is associated with another plot id' do
      visit "/plots/#{@plot2.id}/organisms"

      expect(page).to have_content(@plot2.name)
      expect(page).to have_content("#{@org2.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org2.max_size_sqft} sq ft")
      expect(page).to have_content("#{@org3.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org3.max_size_sqft} sq ft")
      expect(page).to have_content("#{@org4.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org4.max_size_sqft} sq ft")
      expect(page).to have_content("Alive : Yes", count: 2)
      expect(page).to have_content("Alive : No")
    end
  end

  # User Story 8, Organisms Index Link
  describe 'When a user visits /plots/:plot_id/organisms they see a link that take them to organisms index' do
    it 'They see a link that takes them back to /organisms, link bar at top of page' do
      visit "/plots/#{@plot1.id}/organisms"

      expect(page).to have_link('All Organisms', :href=>'/organisms')
      expect(page.find('.topBar')).to appear_before(@org1.name)
    end

    it 'Takes user to /organisms after clicking on link' do
      visit "/plots/#{@plot1.id}/organisms"
      click_on('All Organisms')

      expect(current_path).to eq('/organisms')
    end

    it "Works for another /plots/:plot_id/organisms page with another id " do
      visit "/plots/#{@plot2.id}/organisms"
      click_on('All Organisms')

      expect(current_path).to eq('/organisms')
    end
  end

  # User Story 9, Plot Index Link
  describe 'When a user visits /plots/:plot_id/organisms, they see a link that takes them back to plots index' do
    it 'They see a link that takes them back to /plots, link bar at top of page' do
      visit "/plots/#{@plot1.id}/organisms"

      expect(page).to have_link('All Plots', :href=>'/plots')
      expect(page.find('.topBar')).to appear_before(@plot1.name)
    end

    it 'Takes user to /plots after clicking on link' do
      visit "/plots/#{@plot1.id}/organisms"
      click_on('All Plots')

      expect(current_path).to eq('/plots')
    end

    it 'Works on another /plots/:plot_id/organisms page with another id' do
      visit "/plots/#{@plot2.id}/organisms"
      click_on('All Plots')

      expect(current_path).to eq('/plots')
    end
  end

  # User Story 16, Sort Parent's Children in Alphabetical Order by name 
  describe 'When a user visits /plots/:plot_id/organisms, they see a link to sort these organisms alphebetically' do
    it 'They see a link to sort organisms by name, redirects to self' do
      visit "/plots/#{@plot2.id}/organisms"

      expect(page).to have_link('Sort Alphabetically', :href=>"/plots/#{@plot2.id}/organisms")

      click_on ('Sort Alphabetically')

      expect(current_path).to eq("/plots/#{@plot2.id}/organisms")
    end

    it 'User clicks on link and redirects back to page and now is sorted alphabetically' do
      visit "/plots/#{@plot2.id}/organisms"

      expect("#{@org2.name} is an animal").to appear_before("#{@org3.name} is an animal")
      expect("#{@org3.name} is an animal").to appear_before("#{@org4.name} is an animal")
      expect("#{@org2.name} is an animal").to appear_before("#{@org4.name} is an animal")

      click_on ('Sort Alphabetically')

      expect("#{@org3.name} is an animal").to appear_before("#{@org2.name} is an animal")
      expect("#{@org3.name} is an animal").to appear_before("#{@org4.name} is an animal")
      expect("#{@org2.name} is an animal").to appear_before("#{@org4.name} is an animal")
    end
  end
end