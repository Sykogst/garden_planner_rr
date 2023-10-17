require 'rails_helper'

RSpec.describe 'Organisms index', type: :feature do
  before(:each) do
    @plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
    @org1 = @plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0, alive: true)

    @plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0)
    @org2 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: false)
    @org3 = @plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: true)
    @org4 = @plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 5.0, alive: true)
  end

  # User Story 3, Organism Index & User Story 15, Organism Index only shows alive true
  describe 'When a user visits /organisms' do
    it 'They see each organism in the system including its attributes, only shows alive ones' do
      visit '/organisms'

      expect(page).to have_content('Things Living in the Garden')
      expect(page).to have_content("Alive : Yes", count: 3)
      expect(page).to have_content(@org1.name)
      expect(page).to have_content("#{@org1.name} is a plant")
      expect(page).to have_content("Space Taken : #{@org1.max_size_sqft} sq ft")
      expect(page).to have_content(@org3.name)
      expect(page).to have_content("#{@org3.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org3.max_size_sqft} sq ft")
      expect(page).to have_content(@org4.name)
      expect(page).to have_content("#{@org4.name} is an animal")
      expect(page).to have_content("Space Taken : #{@org4.max_size_sqft} sq ft")
    end
  end

  # User Story 9, Plots Index Link
  describe 'When a user visits /organisms, there is a link to get back to plots index' do
    it 'They see a link that takes them back to /plots, link bar at top of page' do
      visit '/organisms'

      expect(page).to have_link('All Plots', :href=>'/plots')
      expect(page.find('.topBar')).to appear_before(@org1.name)
    end

    it 'Takes user to /plots after clicking on link' do
      visit '/organisms'
      click_on('All Plots')

      expect(current_path).to eq('/plots')
    end
  end

  # User Story 18, Organism Update From Organisms Index Page 
  describe 'When a user visits /organisms there is a link next to each plot to edit the entry' do
    it 'They see a link that takes them back to to the edit page /organisms/:id/edit' do
      visit '/organisms'

      expect(page).to have_link("Update #{@org1.name}", :href=>"/organisms/#{@org1.id}/edit")
      expect(page).to have_link("Update #{@org3.name}", :href=>"/organisms/#{@org3.id}/edit")
      expect(page).to have_link("Update #{@org4.name}", :href=>"/organisms/#{@org4.id}/edit")
    end

    it 'Takes user to /organisms/:id/edit after clicking on link for different ids' do
      visit '/organisms'
      click_on("Update #{@org1.name}")

      expect(current_path).to eq("/organisms/#{@org1.id}/edit")

      visit '/organisms'
      click_on("Update #{@org3.name}")

      expect(current_path).to eq("/organisms/#{@org3.id}/edit")
    end
  end

  # User Story 23, Organism Delete From Organisms Index Page 
  describe 'When a user visits a organisms there is a link to delete each organism' do
    it 'They see a link to delete the organism' do
      visit "/organisms"

      expect(page).to have_content("Delete #{@org1.name}")
      expect(page).to have_content("Delete #{@org3.name}")
      expect(page).to have_content("Delete #{@org4.name}")
    end

    it 'After clicking delete a link, removes it and all related organism records, redirects to index page' do
      visit '/organisms'

      expect(page).to have_content(@org1.name)
      expect(page).to have_content(@org3.name)
      expect(page).to have_content(@org4.name)

      click_on("Delete #{@org1.name}")

      expect(current_path).to eq('/organisms')
      expect(page).not_to have_content(@org1.name)
      expect(page).to have_content(@org3.name)
      expect(page).to have_content(@org4.name)
    end
  end

  # Extension 2: Search by name (exact match)/ Extension 3: Search by name (partial match)
  describe 'When a user visits organisms index page, they see a text box to filter name records by name' do
    it 'They see a text box with Submit to filter by name' do
      visit '/organisms'

      expect(page).to have_content(@org1.name)
      expect(page).to have_content(@org3.name)
      expect(page).to have_content(@org4.name)

      expect(page).to have_content('Search name')
      fill_in('Search name', with: 'Chicken')
      click_on('Submit')

      expect(page).not_to have_content(@org1.name)
      expect(page).to have_content(@org3.name)
      expect(page).not_to have_content(@org4.name)
      expect(current_path).to eq('/organisms')
    end

    it 'They see a text box with Submit to filter by name, can return similar matches' do
      visit '/organisms'

      expect(page).to have_content(@org1.name)
      expect(page).to have_content(@org3.name)
      expect(page).to have_content(@org4.name)

      expect(page).to have_content('Search name')
      fill_in('Search name', with: 'c')
      click_on('Submit')

      expect(page).to have_content(@org1.name)
      expect(page).to have_content(@org3.name)
      expect(page).not_to have_content(@org4.name)
      expect(current_path).to eq('/organisms')
    end
  end
end