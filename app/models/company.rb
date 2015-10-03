class Company < ActiveRecord::Base
  has_many :vouchers, dependent: :restrict_with_exception
  has_many :requisitions, dependent: :restrict_with_exception
  has_many :purchase_orders, dependent: :restrict_with_exception
end
