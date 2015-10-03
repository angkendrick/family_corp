class AddTimestampsToPurchaseOrders < ActiveRecord::Migration
  def change
    add_column :purchase_orders, :created_at, :datetime
    add_column :purchase_orders, :updated_at, :datetime
  end
end
