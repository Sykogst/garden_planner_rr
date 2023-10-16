require 'rails_helper'

RSpec.describe 'Plots index', type: :feature do
  before(:each) do
    old_date = '2022-10-12 [22:22:22]'
    oldest_date = '2021-10-12'
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0, created_at: oldest_date)
    @plot3 = Plot.create!(name: 'Flower Bed', arable: true, area_sqft: 10.0, created_at: old_date)
  end

  # User Story 1, Plots Index 
  describe 'When a user visits /plots' do
    it 'They see the name of each plots record in the system' do
      visit '/plots'

      expect(page).to have_content("Plots of Land")
      expect(page).to have_content(@plot1.name)
      expect(page).to have_content(@plot2.name)
    end
  end

  # User Story 6, Plots Index sorted by Most Recently Created 
  describe 'When a user visits /plots displayed records are sorted' do
    it 'They see the name of each plots record in order of creation with when it was created' do
      visit '/plots'

      expect(page).to have_content(@plot1.created_at)
      expect(page).to have_content(@plot2.created_at)
      expect(page).to have_content(@plot3.created_at)

      expect(@plot2.name).to appear_before(@plot1.name)
      expect(@plot3.name).to appear_before(@plot1.name)
      expect(@plot2.name).to appear_before(@plot3.name)
    end
  end

  # User Story 8, Organisms Index Link
  describe 'When a user visits /plots there is a link to go back to organisms' do
    it 'They see a link that takes them back to /organisms, link bar at top of page' do
      visit '/plots'

      expect(page).to have_link('All Organisms', :href=>'/organisms')
      expect(page.find('.topBar')).to appear_before(@plot2.name)
    end

    it 'Takes user to /organisms after clicking on link' do
      visit '/plots'
      click_on('All Organisms')

      expect(current_path).to eq('/organisms')
    end
  end

  # User Story 17, Plot Update From Plots Index Page 
  describe 'When a user visits /plots there is a link next to each plot to edit the entry' do
    it 'They see a link that takes them back to to the edit page /plots/:id/edit' do
      visit '/plots'

      expect(page).to have_link("Update #{@plot1.name}", :href=>"/plots/#{@plot1.id}/edit")
      expect(page).to have_link("Update #{@plot2.name}", :href=>"/plots/#{@plot2.id}/edit")
      expect(page).to have_link("Update #{@plot2.name}", :href=>"/plots/#{@plot2.id}/edit")
    end

    it 'Takes user to /plots/:id/edit after clicking on link for different ids' do
      visit '/plots'
      click_on("Update #{@plot1.name}")

      expect(current_path).to eq("/plots/#{@plot1.id}/edit")

      visit '/plots'
      click_on("Update #{@plot2.name}")

      expect(current_path).to eq("/plots/#{@plot2.id}/edit")
    end
  end
end