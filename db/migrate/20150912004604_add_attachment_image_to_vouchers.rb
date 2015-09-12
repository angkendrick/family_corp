class AddAttachmentImageToVouchers < ActiveRecord::Migration
  def self.up
    change_table :vouchers do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :vouchers, :image
  end
end
