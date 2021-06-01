# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'gig_seeds.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
  t = Gig.new

    t.artist_name = row['Artist Name']
    t.city = row['City']
    t.country = row['Country']
    t.ticket_price = row['Ticket Price']
    t.description = row['Description']
    t.date = row['Date']
    t.venue = row['Venue']
    t.venue_location = row['Venue Location']
    t.time = row['Time']

    t.save
  end
