# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
plot1 = Plot.create!(name: 'Lawn', arable: true, area_sqft: 100.0)
org1 = plot1.organisms.create!(name: 'Clover', plant: true, max_size_sqft: 50.0, alive: true)
org2 = plot1.organisms.create!(name: 'Grass', plant: true, max_size_sqft: 30.0, alive: false)

plot2 = Plot.create!(name: 'Coop', arable: false, area_sqft: 50.0, created_at: '2022-10-12 [22:22:22]')
org3 = plot2.organisms.create!(name: 'Chicken', plant: false, max_size_sqft: 5.0, alive: true)
org4 = plot2.organisms.create!(name: 'Chick', plant: false, max_size_sqft: 1.0, alive: false)
org5 = plot2.organisms.create!(name: 'Rooster', plant: false, max_size_sqft: 6.0, alive: true)
org5 = plot2.organisms.create!(name: 'Chick', plant: false, max_size_sqft: 1.0, alive: true)