# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def onboarding
    UserMailer.with(id: Person.last.id).onboarding
  end
end
