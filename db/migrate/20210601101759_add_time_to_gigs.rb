class AddTimeToGigs < ActiveRecord::Migration[6.0]
  def change
    add_column :gigs, :time, :time
  end
end
