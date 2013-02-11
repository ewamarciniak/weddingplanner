class AddPhoneNumberToListing < ActiveRecord::Migration
  def change
    add_column :listings, :phone_number, :string
    add_column :listings, :fax_number, :string
    add_column :listings, :email, :string
    add_column :listings, :website, :string

  end
end
