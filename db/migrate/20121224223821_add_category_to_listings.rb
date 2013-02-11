class AddCategoryToListings < ActiveRecord::Migration
  def change
    add_column :listings, :category, :string
    remove_column :todos, :list
  end
end
