require 'rails_helper'

RSpec.describe 'Plots index', type: :feature do
  before(:each) do
    old_date = '2022-10-12 [22:22:22]'
    oldest_date = '2021-10-12 [22:22:22]'
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0, created_at: oldest_date)
    @plot3 = Plot.create!(name: 'Flower Bed', arable: true, area_sqft: 10.0, created_at: old_date)
  end

  # User Story 1, Plots Index 
  describe 'When a user visits /plots' do
    it 'They see the name of each plots record in the system' do
      visit '/plots'

      expect(page).to have_content("All Plots of Land")
      expect(page).to have_content(@plot1.name)
      expect(page).to have_content(@plot2.name)
    end
  end

  # User Story 6, Parent Index sorted by Most Recently Created 
  describe 'When a user visits /plots records are sorted' do
    it 'They see the name of each plots record in order of creation with when it was created' do
      visit '/plots'

      expect(page).to have_content(@plot1.created_at)
      expect(page).to have_content(@plot2.created_at)
      expect(page).to have_content(@plot3.created_at)
save_and_open_page
      expect(@plot2.name).to appear_before(@plot1.name)
      expect(@plot3.name).to appear_before(@plot1.name)
      expect(@plot2.name).to appear_before(@plot3.name)
    end
  end
end