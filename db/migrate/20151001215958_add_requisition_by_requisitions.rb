class AddRequisitionByRequisitions < ActiveRecord::Migration
  def change
    add_column :requisitions, :requested_by_id, :integer
  end
end
