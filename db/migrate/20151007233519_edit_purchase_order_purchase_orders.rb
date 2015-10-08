class EditPurchaseOrderPurchaseOrders < ActiveRecord::Migration
  def change
    rename_column :purchase_orders, :purchase_order, :purchase_order_number
    rename_column :requisitions, :purchase_order, :purchase_order_number
    add_column :purchase_orders, :voucher_id, :integer
  end
end
