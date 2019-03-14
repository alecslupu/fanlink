class CertcoursePage < ApplicationRecord
  belongs_to :certcourse, counter_cache: true

  has_one :quiz_page
  has_one :video_page
  has_one :image_page

  validates_uniqueness_of :certcourse_page_order, scope: %i[ certcourse_id ]

  validates_format_of :background_color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i

  def media_url
  	unless quiz_page.present?
  		"media url"
  	else
  		null
  	end
  end
end
