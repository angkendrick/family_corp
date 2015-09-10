class AddColumnToVoucher < ActiveRecord::Migration
  def change
    add_column :vouchers, :account_id, :integer
    add_column :vouchers, :department_id, :integer
  end
end
