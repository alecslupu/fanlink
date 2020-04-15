class OnboardingEmailJob < ApplicationJob
  queue_as :mailers
  def perform
    # TODO: Need to migrate to deliver_later
    PersonMailer.with(id: person_id).onboarding.deliver_now
  end
end
