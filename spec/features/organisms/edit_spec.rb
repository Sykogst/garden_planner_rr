require 'rails_helper'

RSpec.describe 'Organisms edit', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0, alive: true)
    @org2 = @plot1.organisms.create!(name: 'Grass', plant: true, max_size_sqft: 50.0, alive: true)
  end

  # User Story 14, Organism Update & User Story 15, Organism Index only shows alive true
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

    it 'User fills in form for organism with proper attributes, hit button Submit Update, then redirects back to /organisms with updates' do
      visit "/organisms/#{@org1.id}/edit"

      # Only update one field in form, rest are blank and desired to stay the same
      fill_in('max_size_sqft', with: 30.0)
      click_on('Submit')

      expect(current_path).to eq("/organisms/#{@org1.id}")
      expect(page).to have_content("Space Taken : 30.0 sq ft")
      # Test to see that form did not update this attribute, as nothing was entered
      expect(page).to have_content('Clover')
    end

    it 'After user updates alive from true to false, the organism record is no longer displayed on Organisms index page' do
      visit '/organisms'

      expect(page).to have_content('Grass')

      visit "/organisms/#{@org2.id}"
      click_on('Update Organism')

      fill_in('alive', with: false)
      click_on('Submit')

      expect(current_path).to eq("/organisms/#{@org2.id}")
      expect(page).to have_content("Alive : No")
      
      visit '/organisms'
      expect(page).not_to have_content('Grass')
    end
  end
end