class AddAttachmentPictureToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.has_attached_file :picture
    end
  end

  def self.down
    drop_attached_file :products, :picture
  end
end
