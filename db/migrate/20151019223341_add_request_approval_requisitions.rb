class AddRequestApprovalRequisitions < ActiveRecord::Migration
  def change
    add_column :requisitions, :request_approval, :integer, default: 0
  end
end
