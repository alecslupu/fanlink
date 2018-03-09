class OnboardingEmailJob < Struct.new(:person_id)
  def perform
    person = Person.find(person_id)
    PersonMailer.onboarding(person).deliver
  end

  def error(job, exception)
    if exception.is_a?(Mandrill::UnknownTemplateError)
      job.destroy
    end
  end

end