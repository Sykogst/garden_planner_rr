require 'rails_helper'

RSpec.describe 'Plots index', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
  end

  # User Story 1, Parent Index 
  describe 'When a user visits /plots' do
    it 'They see the name of each plots record in the system' do
      visit '/plots'
save_and_open_page
      expect(page).to have_content("All Plots of Land")
      expect(page).to have_content(@plot1.name)
      expect(page).to have_content(@plot2.name)
    end
  end

  describe 'When a user visits /plots/:id' do
    xit 'They see the plot with that id includings its attributes' do
      expect(page).to have_content(@plot1.name)
      expect(page).to have_content("Contains : plants")
      expect(page).to have_content("Total Area : #{@plot1.area_sqft} sq ft")
      expect(page).to have_content(@plot2.name)
      expect(page).to have_content("Contains : animals")
      expect(page).to have_content("Total Area : #{@plot2.area_sqft} sq ft")
    end
  end
end