class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :description
      t.boolean :completed, :default => false
      t.string :list

      t.timestamps
    end
  end
end
