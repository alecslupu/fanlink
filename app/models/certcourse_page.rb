# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_course_pages
#
#  id                   :bigint           not null, primary key
#  course_id            :integer
#  course_page_order    :integer          default(0), not null
#  duration             :integer          default(0), not null
#  background_color_hex :string           default("#000000"), not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  content_type         :string
#  product_id           :integer          not null
#

class CertcoursePage < Fanlink::Courseware::CoursePage

  def initialize(attributes = nil)
    ActiveSupport::Deprecation.warn("CertcoursePage is deprecated and may be removed from future releases, use  Fanlink::Courseware::CoursePage instead.")
    super
  end


  validates :duration, numericality: { greater_than: 0 }
  validate :single_child_validator

  before_save :set_properties_from_child

  def set_properties_from_child
    return if child.blank?
    self.content_type = child.content_type
    self.duration = child.duration if video?
  end

  validates_format_of :background_color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i

  protected

  def single_child_validator
    errors.add(:base, _('You cannot add a question and a video or image on the same certcourse')) if quiz? && (download? || video? || image?)
    errors.add(:base, _('You cannot add an image and a video or question on the same certcourse')) if image? && (download? || quiz? || video?)
    errors.add(:base, _('You cannot add a video and a question or image on the same certcourse')) if video? && (download? || quiz? || image?)
    errors.add(:base, _('You cannot add a download and a question or image on the same certcourse')) if download? && (video? || quiz? || image?)
  end
end
