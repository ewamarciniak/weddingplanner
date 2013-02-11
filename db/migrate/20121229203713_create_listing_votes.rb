class CreateListingVotes < ActiveRecord::Migration
  def change
    create_table :listing_votes do |t|
      t.belongs_to :listing
      t.belongs_to :user
      t.integer :value

      t.timestamps
    end
    add_index :listing_votes, :listing_id
    add_index :listing_votes, :user_id
  end
end
