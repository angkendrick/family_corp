class Voucher < ActiveRecord::Base

  belongs_to :account
  belongs_to :bank
  belongs_to :customer
  belongs_to :department
  has_many :particulars

  accepts_nested_attributes_for :particulars, allow_destroy: true

  searchkick

  def search_data
    attributes.merge(
         name: customer(&:name),
         title: account(&:title),
         name: department(&:name),
         description: particulars.map(&:description)
    )
  end


  # paperclip dropbox below
  # config/dropbox.yml, linked to application.yml < generated by figaro

  before_save :rename_upload_image

  has_attached_file :cheque_image, :default_url => "default.jpg",
                    storage: :dropbox,
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml")
  validates_attachment_content_type :cheque_image, :content_type => /\Aimage\/.*\Z/


  def rename_upload_image
    puts 'hi'
    if self.cheque_image.dirty?
      extension = File.extname(cheque_image_file_name).downcase
      self.cheque_image.instance_write :file_name, "#{Time.now.strftime("%m%d%Y-%H%M%S")}#{extension}"
    end
  end

end
