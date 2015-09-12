class Voucher < ActiveRecord::Base

  belongs_to :account
  belongs_to :bank
  belongs_to :customer
  belongs_to :department
  has_many :particulars

  accepts_nested_attributes_for :particulars, allow_destroy: true

  has_attached_file :cheque_image, :styles => { :medium => "700x" }, :default_url => "default.jpg",
                    storage: :dropbox,
                    :dropbox_credentials => Rails.root.join("system/dropbox.yml")
  validates_attachment_content_type :cheque_image, :content_type => /\Aimage\/.*\Z/


end
