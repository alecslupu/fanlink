# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_courses
#
#  id                 :bigint           not null, primary key
#  long_name          :string           not null
#  short_name         :string           not null
#  description        :text             default(""), not null
#  color_hex          :string           default("#000000"), not null
#  status             :integer          default("entry"), not null
#  duration           :integer          default(0), not null
#  is_completed       :boolean          default(FALSE)
#  copyright_text     :text             default(""), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_id         :integer          not null
#  course_pages_count :integer          default(0)
#

class Certcourse < Fanlink::Courseware::Course


  def initialize(attributes = nil)
    ActiveSupport::Deprecation.warn("Certcourse is deprecated and may be removed from future releases, use  Fanlink::Courseware::Course instead.")
    super
  end


  validate :children_not_empty, if: :status_changed? && :live?

  protected

  def children_not_empty
    validation_buffer = []
    course_pages.each do |cp|
      validation_buffer.push(cp.id) unless cp.child.present? && cp.child.valid?
    end

    errors.add(:base, _("Cannot publish, at least one page has no content. Please check #{validation_buffer.join(', ')}")) unless validation_buffer.empty?
  end
end
