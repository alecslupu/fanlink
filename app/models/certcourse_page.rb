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
  has_paper_trail
  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :certcourse, counter_cache: true

  has_one :quiz_page
  has_one :video_page
  has_one :image_page
  has_many :course_page_progresses

  accepts_nested_attributes_for :quiz_page, allow_destroy: true
  accepts_nested_attributes_for :video_page, allow_destroy: true
  accepts_nested_attributes_for :image_page, allow_destroy: true

  scope :quizes, -> { joins(:quiz_page) }
  scope :videos, -> { joins(:video_page) }
  scope :images, -> { joins(:image_page) }
  scope :ordered, -> { order(:certcourse_page_order) }

  # validates_uniqueness_to_tenant :certcourse_page_order, scope: %i[ certcourse_id ]
  validates :duration, numericality: { greater_than: 0 }
  validate :single_child_validator

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

  protected
  def single_child_validator
    errors.add(:base, _("You cannot add a question and a video or imaage on the same certcourse")) if quiz_page.present? && (video_page.present? || image_page.present?)
    errors.add(:base, _("You cannot add an image and a video or question on the same certcourse")) if image_page.present? && (quiz_page.present? || video_page.present?)
    errors.add(:base, _("You cannot add a video and a question or imaage on the same certcourse")) if video_page.present? && (quiz_page.present? || image_page.present?)
  end
end
