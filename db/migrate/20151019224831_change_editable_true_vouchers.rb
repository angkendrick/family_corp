class ChangeEditableTrueVouchers < ActiveRecord::Migration
  def change
    change_column_default :vouchers, :editable, true
  end
end
