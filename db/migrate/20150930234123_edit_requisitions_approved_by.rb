class EditRequisitionsApprovedBy < ActiveRecord::Migration
  def change
    rename_column :requisitions, :approved, :approved_by_id
  end
end
