class AddVenueLocationToGigs < ActiveRecord::Migration[6.0]
  def change
    add_column :gigs, :venue_location, :string
  end
end
