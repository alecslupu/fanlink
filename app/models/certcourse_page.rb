class CertcoursePage < ApplicationRecord
  belongs_to :certcourse

  has_one :quiz_page
  has_one :video_page
  has_one :image_page
end
