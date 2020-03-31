class SendAssigneeCertificateEmailJob < ApplicationJob
  queue_as :default

  def perform(person_id, assignee_id, person_certificate_id, email)
    person = Person.find(person_id)
    assignee = Person.find(assignee_id)
    certificate = PersonCertificate.where(id: person_certificate_id).last

    PersonMailer.send_assignee_certificate(person, assignee, certificate, email).deliver!
  end
end
