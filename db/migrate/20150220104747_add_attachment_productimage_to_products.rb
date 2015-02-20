class AddAttachmentProductimageToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :productimage
    end
  end

  def self.down
    remove_attachment :products, :productimage
  end
end
