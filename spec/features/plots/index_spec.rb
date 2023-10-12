require 'rails_helper'

RSpec.describe 'Plots index', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
  end
  # User Story 1, Parent Index 

  # For each parent table
  # As a visitor
  # When I visit '/parents'
  # Then I see the name of each parent record in the system
  describe 'When a user visits /parents' do
    it 'They see the name of each parent record in the system' do
      visit '/plots'

      expect(page).to have_content("All Plots of Land")
      expect(page).to have_content("#{@plot1.name} : This plot is good for plants")
      expect(page).to have_content("Total Area : #{@plot1.area_sqft} square feet")
      expect(page).to have_content("#{@plot2.name} : This plot is good for animals")
      expect(page).to have_content("Total Area : #{@plot2.area_sqft} square feet")
    end
  end
end