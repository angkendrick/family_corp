class RequisitionParticular < ActiveRecord::Base
  belongs_to :requisition
  belongs_to :measurement
end
