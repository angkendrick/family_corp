class Measurement < ActiveRecord::Base
  has_many :requisition_particulars, dependent: :restrict_with_exception
  validates :name, presence: :true
end
