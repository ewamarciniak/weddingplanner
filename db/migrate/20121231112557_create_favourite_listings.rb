class CreateFavouriteListings < ActiveRecord::Migration
  def change
    create_table :favourite_listings do |t|
      t.integer :listing_id
      t.integer :user_id

      t.timestamps
    end
  end
end
