class CertcoursePage < ApplicationRecord

  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :certcourse, counter_cache: true

  has_one :quiz_page
  has_one :video_page
  has_one :image_page

  validates_uniqueness_to_tenant :certcourse_page_order, scope: %i[ certcourse_id ]

  def content_type
    return "quiz" if quiz_page.present?
    return "video" if video_page.present?
    return "image" if image_page.present?
  end

  validates_format_of :background_color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i

  def media_url
    unless quiz_page.present?
      "media url"
    else
      null
    end
  end

  def child
    quiz_page || image_page || video_page
  end
end
