class SendAssigneeCertificateEmailJob < Struct.new(:person_id, :assignee_id, :person_certificate_id, :email)
  def perform
    PersonMailer.with(person: person_id, assignee: assignee_id,person_certificate: person_certificate_id, email: email).send_assignee_certificate.deliver_now
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
