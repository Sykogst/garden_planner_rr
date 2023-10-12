require 'rails_helper'

RSpec.describe 'Plots index', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
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

  # User Story 5, Parent Children Index 
  describe 'When a user visits /plots/:plot_id/organisms' do
    it 'Then they see each organism that is associated with plot id 1 including each organisms attributes' do
      visit "/plots/#{plot1.id}"
      expect().to
    end
  end
  # As a visitor
  # When I visit '/parents/:parent_id/child_table_name'
  # Then I see each Child that is associated with that Parent with each Child's attributes
  # (data from each column that is on the child table)
end