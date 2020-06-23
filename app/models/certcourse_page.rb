# frozen_string_literal: true

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

  has_one :quiz_page, dependent: :destroy
  has_one :video_page, dependent: :destroy
  has_one :image_page, dependent: :destroy
  has_one :download_file_page, dependent: :destroy
  has_many :course_page_progresses, dependent: :destroy

  accepts_nested_attributes_for :quiz_page, allow_destroy: true
  accepts_nested_attributes_for :video_page, allow_destroy: true
  accepts_nested_attributes_for :image_page, allow_destroy: true
  accepts_nested_attributes_for :download_file_page, allow_destroy: true

  scope :quizes, -> { joins(:quiz_page) }
  scope :videos, -> { joins(:video_page) }
  scope :images, -> { joins(:image_page) }
  scope :download_files, -> { joins(:download_file_page) }
  scope :ordered, -> { order(:certcourse_page_order) }
  scope :for_product, -> (product) { where(product_id: product.id) }

  # validates_uniqueness_to_tenant :certcourse_page_order, scope: %i[ certcourse_id ]
  validates :duration, numericality: { greater_than: 0 }
  validate :single_child_validator

  def content_type
    child.content_type
    # return "image" if image?
    # return "download_file" if download?
  end

  def media_content_type
    return image_page.image_content_type if image?
    return video_page.video_content_type if video?
    return download_file_page.document_content_type if download?

    nil
  end

  validates_format_of :background_color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i

  def media_url
    return image_page.image_url if image?
    return video_page.video_url if video?
    return download_file_page.document_url if download?

    nil
  end

  def download?
    download_file_page.present?
  end

  def video?
    video_page.present?
  end

  def child
    quiz_page || image_page || video_page || download_file_page
  end

  def quiz?
    quiz_page.present?
  end

  def image?
    image_page.present?
  end

  protected
  def single_child_validator
    errors.add(:base, _('You cannot add a question and a video or imaage on the same certcourse')) if quiz? && (download? || video? || image?)
    errors.add(:base, _('You cannot add an image and a video or question on the same certcourse')) if image? && (download? || quiz? || video?)
    errors.add(:base, _('You cannot add a video and a question or imaage on the same certcourse')) if video? && (download? || quiz? || image?)
    errors.add(:base, _('You cannot add a download and a question or imaage on the same certcourse')) if download? && (video? || quiz? || image?)
  end
end
