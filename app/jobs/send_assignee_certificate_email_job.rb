# frozen_string_literal: true
class SendAssigneeCertificateEmailJob < ApplicationJob
  queue_as :mailers

  def perform(person_id, assignee_id, person_certificate_id, email)
    person = Person.find(person_id)
    assignee = Person.find(assignee_id)
    certificate = PersonCertificate.where(id: person_certificate_id).last

    PersonMailer.send_assignee_certificate(person, assignee, certificate, email).deliver_now
  end
end
