# frozen_string_literal: true
# == Schema Information
#
# Table name: download_file_pages
#
#  id                    :bigint(8)        not null, primary key
#  certcourse_page_id    :bigint(8)
#  product_id            :bigint(8)
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  caption               :text
#

class DownloadFilePage < ApplicationRecord
  has_paper_trail ignore: [:created_at, :updated_at]

  scope :for_product, -> (product) { where(product_id: product.id) }
  acts_as_tenant(:product)
  belongs_to :product
  belongs_to :certcourse_page

  # include AttachmentSupport
  has_one_attached :document

  validates :document, attached: true,
            size: {less_than: 5.megabytes},
            content_type: {in: %w[application/pdf]}

  def document_url
    document.attached? ? [Rails.application.secrets.cloudfront_url, document.key].join('/') : nil
  end

  after_save :set_certcourse_page_content_type
  validate :just_me

  validates :caption, presence: true
  validates :certcourse_page_id, uniqueness: true

  def course_name
    certcourse_page.certcourse.to_s
  end

  def content_type
    :download_file
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
