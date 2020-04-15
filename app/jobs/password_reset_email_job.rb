class PasswordResetEmailJob < ApplicationJob
  queue_as :mailers
  def perform
    PersonMailer.with(id: person_id).reset_password.deliver_now
  end
end
