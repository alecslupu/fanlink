class PersonMailer < MandrillMailer::TemplateMailer
  default from: nil, view_content_link: true

  def onboarding(person)
    mandrill_mail(
      template: "#{ person.product.internal_name }-onboarding",
      to: { email: person.email, name: person.name }
    )
  end

  def reset_password(person)
    mandrill_mail(
      template: "#{person.product.internal_name}-password-reset",
      subject: "%{name} - Forgot your password" % { name: person.product.name },
      vars: {
        link: "https://#{ENV['PASSWORD_RESET_HOST'] || 'www.fan.link'}/#{person.product.internal_name}/reset_password?token=#{person.reset_password_token}",
        name: person.name
      },
      to: { email: person.email, name: person.name }
    )
  end

  def send_certificate(person)
    mandrill_mail(
      template: "#{person.product.internal_name}-password-reset",
      subject: "%{name} - Your certificate" % { name: person.name },
      vars: {
        link: "https://#{ENV['PASSWORD_RESET_HOST'] || 'www.fan.link'}/#{person.product.internal_name}/#{person.name}",
        name: person.name
      },
      #to: { email: person.email, name: person.name }
      to: { email: "am@flink.to", name: person.name }
    )
  end

private

  # def hostname
  #   MandrillMailer::config.default_url_options[:host]
  # end
end
