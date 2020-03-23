class PasswordResetEmailJob < Struct.new(:person_id)
  def perform
    person = Person.find(person_id)
    PersonMailer.reset_password(person).deliver
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
