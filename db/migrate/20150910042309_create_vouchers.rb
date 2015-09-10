class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.integer :customer
      t.integer :bank
      t.integer :purchase_order
      t.integer :confirmation_number
      t.string :description

      t.timestamps null: false
    end
  end
end
