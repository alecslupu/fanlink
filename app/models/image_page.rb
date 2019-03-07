class ImagePage < ApplicationRecord
  include AttachmentSupport

  has_image_called :image
  validates_attachment_presence :image
  
  belongs_to :certcourse_page

  validate :just_me

  private

  def just_me
    x = CertcoursePage.find(certcourse_page.id)
    child = x.child
    if child && child != self
      errors.add(:base, :just_me, message: _("A page can only have one of video, image, or quiz"))
    end
  end
end
