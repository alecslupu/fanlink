class OnboardingEmailJob < Struct.new(:person_id)
  def perform
    # TODO: Need to migrate to deliver_later
    PersonMailer.with(id: person_id).onboarding.deliver_now
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
