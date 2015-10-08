class AddApprovedByIdPurchaseOrders < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :voucher_number, :integer
    add_column :vouchers, :voucher_number, :integer
  end
end
