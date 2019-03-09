class VideoPage < CertcoursePage
  include AttachmentSupport

  has_video_called :attachment
  validates_attachment_presence :attachment
  do_not_validate_attachment_file_type :attachment
end
