class AddPurchaseOrderIdRequisitions < ActiveRecord::Migration
  def change
    add_column :requisitions, :purchase_order_id, :integer
  end
end
