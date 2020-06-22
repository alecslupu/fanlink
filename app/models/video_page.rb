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
  has_paper_trail ignore: [:created_at, :updated_at]

  scope :for_product, -> (product) { where(product_id: product.id) }
  require 'streamio-ffmpeg'

  acts_as_tenant(:product)
  belongs_to :product

  has_one_attached :video

  validates :video, size: {less_than: 10.megabytes},
            content_type: {in: %w[audio/mpeg audio/mp4 audio/mpeg audio/x-mpeg audio/aac audio/x-aac video/mp4 audio/x-hx-aac-adts]}

  def video_url
    video.attached? ? [Rails.application.secrets.cloudfront_url, video.key].join('/')  : nil
  end

  def video_content_type
    video.attached? ? video.blob.content_type : nil
  end

  validates_uniqueness_of :certcourse_page_id

  belongs_to :certcourse_page, autosave: true

  validate :just_me

  def course_name
    certcourse_page.certcourse.to_s
  end

  def content_type
    :video
  end
  app/models/post_comment.rb
  def duration
    attachable = video.attachment.record.attachment_changes['video'].attachable
    file = case attachable
           when ActionDispatch::Http::UploadedFile, Rack::Test::UploadedFile
             attachable.path
           when Hash
             attachable[:io].path
           end
    Integer(FFMPEG::Movie.new(file).duration) + 1
  end
  private

  def just_me
    return if certcourse_page.new_record?
    target_course_page = CertcoursePage.find(certcourse_page.id)
    child = target_course_page.child
    if child && child != self
      errors.add(:base, :just_me, message: _('A page can only have one of video, image, or quiz'))
    end
  end
end
