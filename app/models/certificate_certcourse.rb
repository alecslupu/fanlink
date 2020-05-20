# frozen_string_literal: true
# == Schema Information
#
# Table name: certificate_certcourses
#
#  id               :bigint(8)        not null, primary key
#  certificate_id   :integer
#  certcourse_id    :integer
#  certcourse_order :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  product_id       :integer          not null
#

class CertificateCertcourse < ApplicationRecord
  has_paper_trail

  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :certificate
  belongs_to :certcourse

  scope :for_certificate, -> (certificate) { where(certificate_id: certificate.id) }
  scope :for_certcourse, -> (certcourse) { where(certcourse_id: certcourse.id) }
  scope :for_product, -> (product) { where(product_id: product.id) }

  validates_uniqueness_of :certcourse_id, scope: :certificate_id
  validates_uniqueness_of :certcourse_order, scope: :certificate_id

  validates :certcourse_order, presence: true, numericality: { greater_than: 0 }
end
