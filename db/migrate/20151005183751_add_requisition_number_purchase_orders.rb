class AddRequisitionNumberPurchaseOrders < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :requisition_number, :integer
  end
end
