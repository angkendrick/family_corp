class EditPurchaseOrderVouchers < ActiveRecord::Migration
  def change
    rename_column :vouchers, :purchase_order, :purchase_order_number
  end
end
