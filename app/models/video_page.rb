class VideoPage < ApplicationRecord
  include AttachmentSupport

  has_video_called :video
  validates_attachment_presence :video
	
  belongs_to :certcourse_page
end
