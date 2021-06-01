class CreateGigs < ActiveRecord::Migration[6.0]
  def change
    create_table :gigs do |t|
      t.string :artist_name
      t.string :city
      t.string :country
      t.integer :ticket_price
      t.string :description
      t.date :date

      t.timestamps
    end
  end
end
