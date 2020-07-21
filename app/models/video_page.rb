# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_video_pages
#
#  id                 :bigint           not null, primary key
#  course_page_id     :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  video_file_name    :string
#  video_content_type :string
#  video_file_size    :integer
#  video_updated_at   :datetime
#  product_id         :integer          not null
#

class VideoPage < Fanlink::Courseware::VideoPage

  def initialize(attributes = nil)
    ActiveSupport::Deprecation.warn("VideoPage is deprecated and may be removed from future releases, use  Fanlink::Courseware::VideoPage instead.")
    super
  end

  def video_url
    ActiveSupport::Deprecation.warn("VideoPage#video_url is deprecated")
    AttachmentPresenter.new(video).url
  end

  def video_content_type
    video.attached? ? video.blob.content_type : nil
  end

  validates :course_page_id, uniqueness: true

  validate :just_me

  def course_name
    certcourse_page.certcourse.to_s
  end

  def content_type
    :video
  end

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
    return if course_page.new_record?

    target_course_page = CertcoursePage.find(course_page.id)
    child = target_course_page.child
    if child && child != self
      errors.add(:base, :just_me, message: _('A page can only have one of video, image, or quiz'))
    end
  end
end
