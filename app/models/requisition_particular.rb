class RequisitionParticular < ActiveRecord::Base
  belongs_to :requisition
  belongs_to :measurement

  validates :quantity, :description, :amount, presence: :true
end
