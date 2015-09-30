class AddCheckedApprovedByVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :checked_by_id, :integer
    add_column :vouchers, :approved_by_id, :integer
  end
end
