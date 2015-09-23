class CreateRequisitionParticulars < ActiveRecord::Migration
  def change
    create_table :requisition_particulars do |t|
      t.integer :requisition_id
      t.integer :quantity
      t.integer :measurement_id
      t.string :description
      t.decimal :amount
      t.timestamps null: false
    end
  end
end
