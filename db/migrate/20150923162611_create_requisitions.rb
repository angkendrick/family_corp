class CreateRequisitions < ActiveRecord::Migration
  def change
    create_table :requisitions do |t|
      t.integer :purchase_order
      t.integer :confirmation_number
      t.integer :measurement_id
      t.integer :customer_id
      t.integer :user_id
      t.integer :asset_id
      t.integer :department_id
      t.integer :company_id
      t.integer :approved
      t.boolean :locked, default: :false
      t.timestamps null: false
    end
  end
end
