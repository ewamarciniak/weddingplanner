class CreateInspirations < ActiveRecord::Migration
  def change
    create_table :inspirations do |t|
      t.has_attached_file :image
      t.string :title
      t.integer :position
      t.integer :user_id
      t.text :notes
      t.string :website_url

      t.timestamps
    end
  end
end
