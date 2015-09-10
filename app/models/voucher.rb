class Voucher < ActiveRecord::Base
  belongs_to :account
  belongs_to :bank
  belongs_to :customer
  belongs_to :department
  has_many :particulars
end
