class PurchaseOrder < ActiveRecord::Base

  belongs_to :customer
  belongs_to :approved_by, class_name: 'User', foreign_key: 'user_id'
  belongs_to :asset
  belongs_to :department
  belongs_to :company
  belongs_to :requisition
  has_many :requisition_particulars
  belongs_to :requested_by, class_name: 'User', foreign_key: 'requisition_requested_by_id'

end
