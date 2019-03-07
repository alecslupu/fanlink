class VideoPage < CertcoursePage
  include AttachmentSupport

  has_video_called :attachment

end
