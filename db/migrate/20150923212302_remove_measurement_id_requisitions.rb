class RemoveMeasurementIdRequisitions < ActiveRecord::Migration
  def change
    remove_column :requisitions, :measurement_id, :integer
  end
end
