class AddRequestApprovalPurchaseOrders < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :request_approval, :integer, default: 0
  end
end
