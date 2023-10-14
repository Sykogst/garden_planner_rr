require 'rails_helper'

RSpec.describe 'Organisms edit', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0)
  end

  # User Story 14, Organism Update 
  describe 'When a user visits /organisms/id there is a link to update this record' do
    it 'They see a link /organisms/new to update current organism record, New organism' do
      visit "/organisms/#{@org1.id}"

      expect(page).to have_link('Update Organism', :href=>"/organisms/#{@org1.id}/edit")
    end

    it 'Takes user to /organisms/:id/edit after clicking on link' do
      visit "/organisms/#{@org1.id}"
      click_on('Update Organism')

      expect(page).to have_content("Update #{@org1.name}")
      expect(current_path).to eq("/organisms/#{@org1.id}/edit")
    end

    xit 'User fills in form for organism with proper attributes, hit button Submit Update, then redirects back to /organisms with updates' do
      visit "/organisms/#{@org1.id}/edit"

      # Only update one field in form, rest are blank and desired to stay the same
      fill_in('max_size_sqft', with: 30.0)
      click_on('Submit')

      expect(current_path).to eq("/organisms/#{@org1.id}")
      expect(page).to have_content("Space Taken : #{@org1.max_size_sqft} sq ft")
      # Test to see that form did not update this attribute, as nothing was entered
      expect(page).to have_content('Clover')
    end
  end
end