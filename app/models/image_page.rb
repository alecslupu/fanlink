# frozen_string_literal: true
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

  scope :for_product, -> (product) { where(product_id: product.id) }

  # include AttachmentSupport
  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :certcourse_page

  has_one_attached :image

  # has_course_image_called :image
  # validates_attachment_presence :image
  validates :image, attached: true,
            size: {less_than: 5.megabytes},
            content_type: {in: %w[image/jpeg image/gif image/png application/pdf]}

  def image_url
    image.attached? ? [Rails.application.secrets.cloudfront_url, image.key].join('/') : nil
  end

  def image_optimal_url
    opts = {resize: [1920, 1080], auto_orient: true, quality: 90}
    image.attached? ? [Rails.application.secrets.cloudfront_url, image.variant(opts).processed.key].join('/') : nil
  end

  validates_uniqueness_of :certcourse_page_id

  after_save :set_certcourse_page_content_type
  validate :just_me

  def course_name
    certcourse_page.certcourse.to_s
  end

  def content_type
    :image
  end

  private

    def just_me
      return if certcourse_page.new_record?
      target_course_page = CertcoursePage.find(certcourse_page.id)
      child = target_course_page.child
      if child && child != self
        errors.add(:base, :just_me, message: _("A page can only have one of video, image, or quiz"))
      end
    end

    def set_certcourse_page_content_type
      page = CertcoursePage.find(self.certcourse_page_id)
      page.content_type = content_type
      page.save
    end
end
