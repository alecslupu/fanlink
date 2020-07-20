# frozen_string_literal: true

# == Schema Information
#
# Table name: courseware_courses
#
#  id                     :bigint           not null, primary key
#  long_name              :string           not null
#  short_name             :string           not null
#  description            :text             default(""), not null
#  color_hex              :string           default("#000000"), not null
#  status                 :integer          default("entry"), not null
#  duration               :integer          default(0), not null
#  is_completed           :boolean          default(FALSE)
#  copyright_text         :text             default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  product_id             :integer          not null
#  certcourse_pages_count :integer          default(0)
#

class Certcourse < Fanlink::Courseware::Course

  self.table_name = :courseware_courses

  # has_many :certificate_certcourses
  # has_many :certificates, through: :certificate_certcourses, dependent: :destroy

  # has_many :person_certcourses
  # has_many :people, through: :person_certcourses, dependent: :destroy

  has_many :certcourse_pages, -> { order(:certcourse_page_order) }, dependent: :destroy

  accepts_nested_attributes_for :certcourse_pages, allow_destroy: true

  validate :children_not_empty, if: :status_changed? && :live?

  protected

  def children_not_empty
    validation_buffer = []
    certcourse_pages.each do |cp|
      validation_buffer.push(cp.id) unless cp.child.present? && cp.child.valid?
    end

    errors.add(:base, _("Cannot publish, at least one page has no content. Please check #{validation_buffer.join(', ')}")) unless validation_buffer.empty?
  end
end
