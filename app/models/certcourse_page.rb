class CertcoursePage < ApplicationRecord
  belongs_to :certcourse, counter_cache: true

  has_one :quiz_page
  has_one :video_page
  has_one :image_page

  validates_uniqueness_of :certcourse_page_order, scope: %i[ certcourse_id ]

  def media_url
  	unless quiz_page.present?
  		"media url"
  	else
  		null
  	end
  end
end
