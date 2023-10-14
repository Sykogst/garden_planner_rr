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

  # User Story 11, Plot Creation 
  describe 'When a user visits /plots there is a link to create a new record' do
    it 'They see a link /plots/new to create a new plot record, New Plot' do
      visit '/plots'

      expect(page).to have_link('New Plot', :href=>'/plots/new')
    end

    it 'Takes user to /plots/new after clicking on link' do
      visit '/plots'
      click_on('New Plot')

      expect(current_path).to eq('/plots/new')
    end

    it 'User fills in form for plot with proper attributes, hit button Create Plot, then redirects back to /plots' do
      visit '/plots/new'

      fill_in('name', with: 'Vegetable Patch')
      fill_in('arable', with: true)
      fill_in('area_sqft', with: 20.0)
      click_on('Create Plot')

      expect(current_path).to eq('/plots')
      expect(page).to have_content('Vegetable Patch')
    end
  end
  # As a visitor
  # When I visit the Parent Index page
  # Then I see a link to create a new Parent record, "New Parent"
  # When I click this link
  # Then I am taken to '/parents/new' where I  see a form for a new parent record
  # When I fill out the form with a new parent's attributes:
  # And I click the button "Create Parent" to submit the form
  # Then a `POST` request is sent to the '/parents' route,
  # a new parent record is created,
  # and I am redirected to the Parent Index page where I see the new Parent displayed.
end