class SendAssigneeCertificateEmailJob < ApplicationJob
  queue_as :mailers

  def perform(person_id, assignee_id, person_certificate_id, email)
    PersonMailer.with(person: person_id, assignee: assignee_id,person_certificate: person_certificate_id, email: email).send_assignee_certificate.deliver_now
  end
end
