class SendCertificateEmailJob < ApplicationJob
  queue_as :default

  def perform(person_id, certificate_id, email)
    person = Person.find(person_id)
    certificate = PersonCertificate.where(person_id: person_id, certificate_id: certificate_id).last

    PersonMailer.send_certificate(person, certificate, email).deliver!
  end
end
