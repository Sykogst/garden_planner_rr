require 'rails_helper'

RSpec.describe 'Plots show' do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
  end

  # User Story 2, Plots Show 
  describe 'When a user visits /plots/:id' do
    it 'They see the plot with that id of 1 including its attributes' do
      visit "plots/#{@plot1.id}"

      expect(page).to have_content(@plot1.name)
      expect(page).to have_content("Contains : plants")
      expect(page).to have_content("Total Area : #{@plot1.area_sqft} sq ft")
    end

    it 'They see the plot with that id of 2 including its attributes' do
      visit "plots/#{@plot2.id}"

      expect(page).to have_content(@plot2.name)
      expect(page).to have_content("Contains : animals")
      expect(page).to have_content("Total Area : #{@plot2.area_sqft} sq ft")
    end
  end
end