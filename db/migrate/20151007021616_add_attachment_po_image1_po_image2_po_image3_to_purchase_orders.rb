class AddAttachmentPoImage1PoImage2PoImage3ToPurchaseOrders < ActiveRecord::Migration
  def self.up
    change_table :purchase_orders do |t|
      t.attachment :po_image1
      t.attachment :po_image2
      t.attachment :po_image3
    end
  end

  def self.down
    remove_attachment :purchase_orders, :po_image1
    remove_attachment :purchase_orders, :po_image2
    remove_attachment :purchase_orders, :po_image3
  end
end
