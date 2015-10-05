class Requisition < ActiveRecord::Base
  belongs_to :asset
  belongs_to :department
  belongs_to :customer
  belongs_to :company
  has_many :requisition_particulars, dependent: :destroy
  belongs_to :user
  belongs_to :requested_by, class_name: 'User', foreign_key: 'requested_by_id'

  accepts_nested_attributes_for :requisition_particulars, allow_destroy: true
  validates_associated :requisition_particulars

  validates :requested_by_id, presence: :true
  validates :requisition_number, uniqueness: :true

  # paperclip dropbox below
  # config/dropbox.yml, linked to application.yml < generated by figaro

  before_save :rename_upload_image

  has_attached_file :requisition_image, :default_url => "default.jpg",
                    storage: :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
                    :path => 'requisition/:filename'
  validates_attachment_content_type :requisition_image, :content_type => /\Aimage\/.*\Z/

  protected

  def rename_upload_image
    if self.requisition_image.dirty?
      Time.zone = 'Singapore'
      extension = File.extname(requisition_image_file_name).downcase
      self.requisition_image.instance_write :file_name, "#{Time.zone.now.strftime("%m-%d-%Y")}/requisition_#{Time.zone.now.strftime("%m%d%Y-%H%M%S")}#{extension}"
    end
  end

end
