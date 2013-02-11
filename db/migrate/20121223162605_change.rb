class Change < ActiveRecord::Migration
  def self.up
    change_table :guests do |t|
      t.change :invitation_sent, :date
    end
  end
  def self.down
    change_table :guests do |t|
      t.change :invitation_sent, :boolean
    end
  end
end
