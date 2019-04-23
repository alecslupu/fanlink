# == Schema Information
#
# Table name: certcourse_pages
#
#  id                    :bigint(8)        not null, primary key
#  certcourse_id         :integer
#  certcourse_page_order :integer          default(0), not null
#  duration              :integer          default(0), not null
#  background_color_hex  :string           default("#000000"), not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  content_type          :string
#  product_id            :integer          not null
#

class CertcoursePage < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :certcourse, counter_cache: true

  has_one :quiz_page
  has_one :video_page
  has_one :image_page
  has_many :course_page_progresses

  validates_uniqueness_to_tenant :certcourse_page_order, scope: %i[ certcourse_id ]
  validates :duration, numericality: { greater_than: 0 }

  def content_type
    return "quiz" if quiz?
    return "video" if video_page.present?
    return "image" if image_page.present?
  end

  validates_format_of :background_color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i

  def media_url
    return if quiz?

    "media url"
  end

  def child
    quiz_page || image_page || video_page
  end

  def quiz?
    quiz_page.present?
  end
end
