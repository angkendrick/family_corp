class Asset < ActiveRecord::Base
  has_many :requisitions, dependent: :restrict_with_exception
  validates :name, presence: :true
end
