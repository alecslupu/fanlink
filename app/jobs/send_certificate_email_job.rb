class SendCertificateEmailJob < Struct.new(:person_id, :certificate_id, :email)
  def perform
    person = Person.find(person_id)
    certificate = PersonCertificate.where(person_id: person_id, certificate_id: certificate_id).last

    PersonMailer.send_certificate(person, certificate, email).deliver
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
