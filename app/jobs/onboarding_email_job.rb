# frozen_string_literal: true
class OnboardingEmailJob < ApplicationJob
  queue_as :mailers

  def perform(person_id)
    person = Person.find(person_id)
    PersonMailer.onboarding(person).deliver_now
  end
end
