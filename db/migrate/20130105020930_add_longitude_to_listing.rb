class AddLongitudeToListing < ActiveRecord::Migration
  def change
    add_column :listings, :longitude, :float
    add_column :listings, :latitude, :float
    add_column :listings, :address, :string
    add_column :listings, :gmaps, :boolean
  end
end
