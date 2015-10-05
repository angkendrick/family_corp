class AddRequisitionNumberRequisitions < ActiveRecord::Migration
  def change
    add_column :requisitions, :requisition_number, :integer
  end
end
