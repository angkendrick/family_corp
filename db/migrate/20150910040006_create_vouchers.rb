class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|

      t.timestamps null: false
    end
  end
end
