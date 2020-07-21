# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_image_pages
#
#  id                 :bigint           not null, primary key
#  course_page_id     :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  product_id         :integer          not null
#

class ImagePage < Fanlink::Courseware::ImagePage

  def initialize(attributes = nil)
    ActiveSupport::Deprecation.warn("ImagePage is deprecated and may be removed from future releases, use  Fanlink::Courseware::ImagePage instead.")
    super
  end

  def image_url
    ActiveSupport::Deprecation.warn("ImagePage#image_url is deprecated")
    AttachmentPresenter.new(image).url
  end

  def image_optimal_url
    ActiveSupport::Deprecation.warn("ImagePage#image_optimal_url is deprecated")
    AttachmentPresenter.new(image).quality_optimal_url
  end

  def image_content_type
    image.attached? ? image.blob.content_type : nil
  end

  validates :course_page_id, uniqueness: true

  validate :just_me

  def course_name
    certcourse_page.certcourse.to_s
  end

  def content_type
    :image
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
