class Remove < ActiveRecord::Migration
  def up
    remove_column :users, :vendor
  end

  def down
    add_column :users, :vendor, :boolean
  end
end
