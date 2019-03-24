class Person
  module Mailing
    def send_onboarding_email
      Delayed::Job.enqueue(OnboardingEmailJob.new(self.id))
    end

    def send_password_reset_email
      Delayed::Job.enqueue(PasswordResetEmailJob.new(self.id))
    end

    def send_certificate_email(certificate_id, email)
      Delayed::Job.enqueue(SendCertificateEmailJob.new(self.id, certificate_id, email))
    end
  end
end
