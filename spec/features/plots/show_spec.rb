require 'rails_helper'

RSpec.describe 'Plots show', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org3 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0)
  end

  # User Story 2, Plots Show 
  describe 'When a user visits /plots/:id' do
    it 'They see the plot with that id including its attributes' do
      visit "plots/#{@plot1.id}"

      expect(page).to have_content(@plot1.name)
      expect(page).to have_content("Contains : plants")
      expect(page).to have_content("Total Area : #{@plot1.area_sqft} sq ft")
    end

    it 'They see a different plot with another id including its attributes' do
      visit "plots/#{@plot2.id}"

      expect(page).to have_content(@plot2.name)
      expect(page).to have_content("Contains : animals")
      expect(page).to have_content("Total Area : #{@plot2.area_sqft} sq ft")
    end
  end

  # User Story 7, Plot Organisms Count
  describe 'When a user visits /plots/:id, it includes count of organisms' do
    it 'They see the plot with that id including count of organisms' do
      visit "plots/#{@plot1.id}"

      expect(@plot1.organisms_count).to eq(1)
      expect(page).to have_content("Organism Count : #{@plot1.organisms_count}")
    end

    it 'They see a different plot with another count of organisms' do
      visit "plots/#{@plot2.id}"

      expect(@plot2.organisms_count).to eq(3)
      expect(page).to have_content("Organism Count : #{@plot2.organisms_count}")
    end
  end

  # User Story 8, Organisms Index Link
  describe 'When a user visits /plots/:id there is a link to go back to organisms' do
    it 'They see a link that takes them back to /organisms, at top of page' do
      visit "plots/#{@plot1.id}"

      expect(page).to have_link('All Organisms', :href=>'/organisms')
      expect(page.find('.topBar')).to appear_before(@plot1.name)
    end

    it 'Takes user to /organisms after clicking on link' do
      visit "plots/#{@plot1.id}"
      click_on('All Organisms')

      expect(current_path).to eq('/organisms')
    end

    it "Works for another /plots/:id page with another id " do
      visit "plots/#{@plot2.id}"
      click_on('All Organisms')

      expect(current_path).to eq('/organisms')
    end
  end

  # User Story 9, Plots Index Link
  describe 'When a user visits /plots/:id there is a link to go back to all plots' do
    it 'They see a link that takes them back to /plots, link bar at top of page' do
      visit "/plots/#{@plot1.id}"

      expect(page).to have_link('All Plots', :href=>'/plots')
      expect(page.find('.topBar')).to appear_before(@plot1.name)
    end

    it 'Takes user to /plots after clicking on link' do
      visit "/plots/#{@plot1.id}"
      click_on('All Plots')

      expect(current_path).to eq('/plots')
    end

    it 'Works on another /plots/:id page with another id' do
      visit "/plots/#{@plot2.id}"
      click_on('All Plots')

      expect(current_path).to eq('/plots')
    end
  end

  # User Story 10, Plots Organisms Index Link
  describe 'When a user visits a plots/:id there is a link to all organisms on this plot' do
    it 'They see a link that takes them to /plots/:plot_id/organisms' do
      visit "/plots/#{@plot1.id}"
      
      expect(page).to have_link('Organisms on this Plot', :href=>"/plots/#{@plot1.id}/organisms")
    end

    it 'Takes user to /plots/:plot_id/organisms after clicking on link' do
      visit "/plots/#{@plot1.id}"
      click_on('Organisms on this Plot')

      expect(current_path).to eq("/plots/#{@plot1.id}/organisms")
    end

    it 'Works on another /plots/:plot_id/organisms page with another id' do
      visit "/plots/#{@plot2.id}"
      click_on('Organisms on this Plot')

      expect(current_path).to eq("/plots/#{@plot2.id}/organisms")
    end
  end

  # User Story 12, Plot Update 
  describe 'When a user visits /plots/id there is a link to update this record' do
    it 'They see a link /plots/new to update current plot record, New Plot' do
      visit "/plots/#{@plot1.id}"
# save_and_open_page
      expect(page).to have_link('Update Plot', :href=>"/plots/#{@plot1.id}/edit")
    end

    xit 'Takes user to /plots/:plot_id/edit after clicking on link' do
      visit "/plots/#{@plot1.id}"
      click_on('Update Plot')

      expect(page).to have_content("Update #{@plot1.name}")
      expect(current_path).to eq("/plots/#{@plot1.id}/edit")
    end

    xit 'User fills in form for plot with proper attributes, hit button Submit Update, then redirects back to /plots with updates' do
      visit "/plots/#{@plot1.id}/edit"

      fill_in('name', with: 'Pumpkin Patch')
      click_on('Submit')

      expect(current_path).to eq("/plots/#{@plot1.id}")
      # Test to see that form did not update this attribute
      expect(page).to have_content("Total Area : 100.0 sq ft")
    end
  end
# As a visitor
# When I visit a parent show page
# Then I see a link to update the parent "Update Parent"
# When I click the link "Update Parent"
# Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/parents/:id',
# the parent's info is updated,
# and I am redirected to the Parent's Show page where I see the parent's updated info
end