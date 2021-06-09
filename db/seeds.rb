# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

Gig.destroy_all

csv_text = File.read(Rails.root.join('lib', 'seeds', 'final_seed.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
  t = Gig.new

    t.artist_name = row['artist_name']
    t.city = row['city']
    t.country = row['country']
    t.ticket_price = row['ticket_price']
    t.description = row['description']
    t.date = row['date']
    t.venue = row['venue']
    t.venue_location = row['venue_location']
    t.time = row['time']
    t.image_url = row['image_url']

    t.save
  end
