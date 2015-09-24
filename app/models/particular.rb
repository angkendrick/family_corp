class Particular < ActiveRecord::Base
  belongs_to :voucher
  validates :description, :amount, presence: :true
end
