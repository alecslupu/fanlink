class SendCertificateEmailJob < Struct.new(:person_id)
  def perform
    person = Person.find(person_id)
    PersonMailer.send_certificate(person, certificate).deliver
  end
  def error(job, exception)
    if exception.is_a?(Mandrill::UnknownTemplateError)
      Delayed::Job.where(id: job.id).destroy_all
    end
  end
end