class AddPurchaseOrderToRequisitionParticulars < ActiveRecord::Migration
  def change
    add_column :requisition_particulars, :purchase_order_id, :integer
  end
end
