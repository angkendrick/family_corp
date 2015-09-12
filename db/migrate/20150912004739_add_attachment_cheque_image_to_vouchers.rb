class AddAttachmentChequeImageToVouchers < ActiveRecord::Migration
  def self.up
    change_table :vouchers do |t|
      t.attachment :cheque_image
    end
  end

  def self.down
    remove_attachment :vouchers, :cheque_image
  end
end
