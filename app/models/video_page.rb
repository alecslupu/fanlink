class VideoPage < ApplicationRecord
  include AttachmentSupport

  has_video_called :video
	
  belongs_to :certcourse_page
end
