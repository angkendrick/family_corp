class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.integer :customer_id
      t.integer :bank_id
      t.integer :purchase_order
      t.integer :confirmation_number
      t.string :description
      t.integer :cheque_number
      t.date :cheque_date
      t.timestamps null: false
    end
  end
end
