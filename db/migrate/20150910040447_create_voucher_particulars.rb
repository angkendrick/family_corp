class CreateVoucherParticulars < ActiveRecord::Migration
  def change
    create_table :voucher_particulars do |t|

      t.timestamps null: false
    end
  end
end
