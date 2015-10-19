class AddEditableVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :editable, :boolean, default: :false
  end
end
