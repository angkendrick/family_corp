class Particular < ActiveRecord::Base
  belongs_to :voucher
  validates :name, :amount, presence: :true
end
