class PasswordResetEmailJob < ApplicationJob
  queue_as :default

  def perform(person_id)
    person = Person.find(person_id)
    PersonMailer.reset_password(person).deliver!
  end
end
