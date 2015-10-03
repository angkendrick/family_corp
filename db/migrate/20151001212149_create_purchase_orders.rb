class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.integer 'purchase_order'
      t.integer 'confirmation_number'
      t.integer 'customer_id'
      t.integer 'user_id'
      t.integer 'asset_id'
      t.integer 'department_id'
      t.integer 'company_id'
      t.integer 'requisition_requested_by_id'
      t.integer 'requisition_id'
    end
  end
end
