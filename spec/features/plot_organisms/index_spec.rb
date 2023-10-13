require 'rails_helper'

RSpec.describe 'Plots Organisms index', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org3 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0)
  end

  # User Story 5, Parent Children Index 
  describe 'When a user visits /plots/:plot_id/organisms' do
    it 'Then they see each organism and its attributes that is associated with that plot id' do
      visit "/plots/#{@plot1.id}/organisms"

      expect(page).to have_content(@plot1.name)
      expect(page).to have_content("#{@org1.name} is a plant")
      expect(page).to have_content("Space Taken : #{@org1.max_size_sqft} sq ft")
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
    end
  end

  # User Story 8, Organisms Index Link
  describe 'When a user visits /plots/:plot_id/organisms' do
    it 'They see a link that takes them back to /organisms' do
      visit "/plots/#{@plot1.id}/organisms"

      expect(page).to have_link('All Organisms', :href=>'/organisms')
    end

    it 'They see a link bar at top of page' do
      visit "/plots/#{@plot1.id}/organisms"
save_and_open_page
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
end