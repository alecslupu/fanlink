class OnboardingEmailJob < ApplicationJob
  queue_as :default

  def perform(person_id)
    person = Person.find(person_id)
    PersonMailer.onboarding(person).deliver!
  end
end
