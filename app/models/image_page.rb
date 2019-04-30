# == Schema Information
#
# Table name: image_pages
#
#  id                 :bigint(8)        not null, primary key
#  certcourse_page_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  product_id         :integer          not null
#

class ImagePage < ApplicationRecord
  include AttachmentSupport
  acts_as_tenant(:product)
  belongs_to :product

  has_course_image_called :image
  validates_attachment_presence :image

  validates_uniqueness_of :certcourse_page_id

  belongs_to :certcourse_page
  has_course_image_called :image

  validates_attachment_presence :image
  after_save :set_certcourse_page_content_type
  validate :just_me

  private

    def just_me
      return if certcourse_page.new_record?
      x = CertcoursePage.find(certcourse_page.id)
      child = x.child
      if child && child != self
        errors.add(:base, :just_me, message: _("A page can only have one of video, image, or quiz"))
      end
    end

    def set_certcourse_page_content_type
      page = CertcoursePage.find(self.certcourse_page_id)
      page.content_type = "image"
      page.save
    end
end
