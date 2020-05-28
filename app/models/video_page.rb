# frozen_string_literal: true
# == Schema Information
#
# Table name: video_pages
#
#  id                 :bigint(8)        not null, primary key
#  certcourse_page_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  video_file_name    :string
#  video_content_type :string
#  video_file_size    :integer
#  video_updated_at   :datetime
#  product_id         :integer          not null
#

class VideoPage < ApplicationRecord
  scope :for_product, -> (product) { where(product_id: product.id) }
  include AttachmentSupport
  require 'streamio-ffmpeg'

  acts_as_tenant(:product)
  belongs_to :product

  has_video_called :video
  validates_attachment_presence :video
  do_not_validate_attachment_file_type :video

  validates_uniqueness_of :certcourse_page_id

  belongs_to :certcourse_page

  validate :just_me
  after_save :set_certcourse_page_content_type
  after_save :set_certcourse_page_duration

  def course_name
    certcourse_page.certcourse.to_s
  end

  def content_type
    :video
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
      page = CertcoursePage.find(certcourse_page_id)
      page.content_type = content_type
      page.save
    end

    def video_duration
      FFMPEG::Movie.new(Paperclip.io_adapters.for(video).path).duration.to_i + 1
    end
    def set_certcourse_page_duration
      certcourse_page.update(duration: video_duration)
    end
end
