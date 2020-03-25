class SendAssigneeCertificateEmailJob < Struct.new(:person_id, :assignee_id, :person_certificate_id, :email)
  def perform
    person = Person.find(person_id)
    assignee = Person.find(assignee_id)
    certificate = PersonCertificate.where(id: person_certificate_id).last

    PersonMailer.send_assignee_certificate(person, assignee, certificate, email).deliver
  end
  def error(job, exception)
    if exception.is_a?(Mandrill::UnknownTemplateError)
      Delayed::Job.where(id: job.id).destroy_all
    end
  end

  def queue_name
    :default
  end
end
