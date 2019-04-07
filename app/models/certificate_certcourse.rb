class CertificateCertcourse < ApplicationRecord
  acts_as_tenant(:product)
  belongs_to :product

  belongs_to :certificate
  belongs_to :certcourse

  scope :for_certificate, -> (certificate) { where(certificate_id: certificate.id) }
  scope :for_certcourse, -> (certcourse) { where(certcourse_id: certcourse.id) }

  validates_uniqueness_of :certcourse_id, scope: :certificate_id
  validates_uniqueness_of :certcourse_order, scope: :certificate_id
end
