class AddAttachmentRequisitionImageToRequisitions < ActiveRecord::Migration
  def self.up
    change_table :requisitions do |t|
      t.attachment :requisition_image
    end
  end

  def self.down
    remove_attachment :requisitions, :requisition_image
  end
end
