class AddApprovalNumberToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :approval_number, :integer
  end
end
