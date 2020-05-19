class PasswordResetEmailJob < ApplicationJob
  queue_as :mailers

  def perform(person_id)
    person = Person.find(person_id)
    PersonMailer.reset_password(person).deliver_now
  end
end
