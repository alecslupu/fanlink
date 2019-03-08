class VideoPage < CertcoursePage
  include AttachmentSupport

  has_video_called :video
  validates_attachment_presence :video
  do_not_validate_attachment_file_type :video
  
end
