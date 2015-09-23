class Requisition < ActiveRecord::Base
  belongs_to :asset
  belongs_to :department
  belongs_to :customer
  belongs_to :company
  has_many :requisition_particulars, dependent: :restrict_with_exception
  belongs_to :user
end
