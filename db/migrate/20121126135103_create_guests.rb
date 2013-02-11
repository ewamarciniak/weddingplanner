class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :title
      t.string :first_name
      t.string :last_name
      t.boolean :invitation_sent
      t.string :rsvp
      t.string :relationship
      t.string :spec_food_req

      t.timestamps
    end
  end
end
