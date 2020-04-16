class SendCertificateEmailJob < ApplicationJob
  queue_as :mailers

  def perform(person_id, certificate_id, email)
    person = Person.find(person_id)
    certificate = PersonCertificate.where(person_id: person_id, certificate_id: certificate_id).last

    PersonMailer.with(id: person_id, person_certificate: certificate.id, email: email).send_certificate.deliver_now
  end
end
