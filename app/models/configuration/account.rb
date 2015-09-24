class Account < ActiveRecord::Base
  has_many :vouchers, dependent: :restrict_with_exception
  validates :title, presence: :true
end
