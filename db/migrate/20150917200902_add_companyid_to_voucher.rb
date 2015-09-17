class AddCompanyidToVoucher < ActiveRecord::Migration
  def change
    add_column :vouchers, :company_id, :integer
  end
end
