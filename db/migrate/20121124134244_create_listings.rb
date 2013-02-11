class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :business_name
      t.has_attached_file :picture
      t.text :description
      t.integer :user_id


      t.timestamps
    end
  end
end
