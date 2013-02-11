class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login_name
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :email
      t.string :password_digest
      t.string :billing_address_line1
      t.string :billing_address_line2
      t.string :billing_address_city
      t.integer :billing_address_postcode
      t.string :billing_address_county
      t.string :shipping_address_line1
      t.string :shipping_address_line2
      t.string :shipping_address_city
      t.integer :shipping_address_postcode
      t.string :shipping_address_county
      t.boolean :vendor, :default => false
      t.boolean :admin, :default => false

      t.timestamps
    end
  end
end
