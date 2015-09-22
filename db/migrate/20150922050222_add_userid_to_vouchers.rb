class AddUseridToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :user_id, :integer
  end
end
