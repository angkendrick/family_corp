class Department < ActiveRecord::Base
  validates :name, presence: :true
  has_many :vouchers, dependent: :restrict_with_exception
  has_many :requisitions, dependent: :restrict_with_exception
end
