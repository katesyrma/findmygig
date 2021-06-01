class AddVenueToGigs < ActiveRecord::Migration[6.0]
  def change
    add_column :gigs, :venue, :string
  end
end
