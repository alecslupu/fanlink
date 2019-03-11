class VideoPage < ApplicationRecord
  include AttachmentSupport

  has_video_called :video
  validates_attachment_presence :video
  do_not_validate_attachment_file_type :video

  validates_uniqueness_of :certcourse_page_id
	
  belongs_to :certcourse_page

  after_save :set_certcourse_page_content_type

  def product
  	Product.find_by(internal_name: "caned")
  end
 
  private

  def set_certcourse_page_content_type
  	page = CertcoursePage.find(certcourse_page_id)
  	page.content_type = "video"
  	page.save
  end
end
