class CreateParticulars < ActiveRecord::Migration
  def change
    create_table :particulars do |t|
      t.integer :voucher_id
      t.string :description
      t.decimal :amount
      t.timestamps null: false
    end
  end
end
