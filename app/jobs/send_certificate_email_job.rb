class SendCertificateEmailJob < Struct.new(:person_id, :certificate_id, :email)
  def perform
    certificate = PersonCertificate.where(person_id: person_id, certificate_id: certificate_id).last
    PersonMailer.with(id: person_id, person_certificate: certificate.id, email: email).send_certificate.deliver_now
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
