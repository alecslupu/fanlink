# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_download_file_pages
#
#  id                    :bigint           not null, primary key
#  course_page_id        :bigint
#  product_id            :bigint
#  document_file_name    :string
#  document_content_type :string
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  caption               :text
#

class DownloadFilePage < Fanlink::Courseware::DownloadFilePage

  def initialize(attributes = nil)
    ActiveSupport::Deprecation.warn("DownloadFilePage is deprecated and may be removed from future releases, use  Fanlink::Courseware::DownloadFilePage instead.")
    super
  end

  def document_url
    ActiveSupport::Deprecation.warn("DownloadFilePage#document_url is deprecated")
    AttachmentPresenter.new(document).url
  end

  def document_content_type
    document.attached? ? document.blob.content_type : nil
  end

  validate :just_me

  validates :caption, presence: true
  validates :course_page_id, uniqueness: true

  def course_name
    certcourse_page.certcourse.to_s
  end

  def content_type
    :download_file
  end

  private

  def just_me
    return if course_page.new_record?

    target_course_page = CertcoursePage.find(course_page.id)
    child = target_course_page.child
    if child && child != self
      errors.add(:base, :just_me, message: _('A page can only have one of video, image, or quiz'))
    end
  end
end
