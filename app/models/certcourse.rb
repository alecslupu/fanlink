# frozen_string_literal: true

# == Schema Information
#
# Table name: certcourses
#
#  id                     :bigint(8)        not null, primary key
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

class Certcourse < ApplicationRecord
  has_paper_trail
  acts_as_tenant(:product)
  belongs_to :product

  has_many :certificate_certcourses
  has_many :certificates, through: :certificate_certcourses, dependent: :destroy

  has_many :person_certcourses
  has_many :people, through: :person_certcourses, dependent: :destroy

  has_many :certcourse_pages, -> { order(:certcourse_page_order) }

  accepts_nested_attributes_for :certcourse_pages, allow_destroy: true

  validates_format_of :color_hex, with: /\A#?(?:[A-F0-9]{3}){1,2}\z/i

  enum status: %i[entry live]

  validates :long_name, :short_name, :description, :color_hex, :status, :duration, :copyright_text, presence: true
  validates_format_of :color_hex, with: /\A#(?:[A-F0-9]{3}){1,2}\z/i
  validates :duration, numericality: { greater_than: 0 }

  scope :live_status, -> { where(status: "live") }
  scope :for_product, -> (product) { where(product_id: product.id) }

  validate :children_not_empty, if: :status_changed? && :live?

  before_destroy :delete_dependent_pages

  def to_s
    short_name
  end

  alias :title :to_s

  protected

  def children_not_empty
    validation_buffer  = []
    certcourse_pages.each do |cp|
      validation_buffer.push(cp.id) unless cp.child.present? && cp.child.valid?
    end

    errors.add(:base, _("Cannot publish, at least one page has no content. Please check #{validation_buffer.join(', ')}")) unless validation_buffer.empty?
  end

  def delete_dependent_pages
    CertcoursePage.where(certcourse_id: id).destroy_all
  end
end
