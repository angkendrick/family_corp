class PurchaseOrder < ActiveRecord::Base

  belongs_to :customer
  belongs_to :user
  belongs_to :asset
  belongs_to :department
  belongs_to :company
  belongs_to :requisition
  has_many :requisition_particulars

end
