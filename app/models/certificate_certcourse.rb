class CertificateCertcourse < ApplicationRecord
  belongs_to :certificate
  belongs_to :certcourse

  scope :for_certificate, -> (certificate) {where(certificate_id: certificate.id)}
  scope :for_certcourse, -> (certcourse) {where(certcourse_id: certcourse.id)}
end

