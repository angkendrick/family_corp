class AddCompanyCodeCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :code, :string
  end
end
