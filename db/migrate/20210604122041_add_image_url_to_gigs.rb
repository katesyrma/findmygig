class AddImageUrlToGigs < ActiveRecord::Migration[6.0]
  def change
    add_column :gigs, :image_url, :string
  end
end
