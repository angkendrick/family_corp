class AddApprovedByIdPruchaseOrders < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :approved_by_id, :integer
  end
end
