class Person
  module Mailing
    def send_onboarding_email
      Delayed::Job.enqueue(OnboardingEmailJob.new(self.id))
    end

    def send_password_reset_email
      Delayed::Job.enqueue(PasswordResetEmailJob.new(self.id))
    end

    def send_certificate_email(certificate)
      Delayed::Job.enqueue(SendCertificateEmailJob.new(self.id, certificate))
    end
  end
end
