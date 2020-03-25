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

  def send_downloaded_file(person, certcourse_page)
    mandrill_mail(
      template: "oasis-document-download",
      subject: "%{name} - Your requested file" % { name: person.name },
      vars: {
        link: "https://#{ENV['PASSWORD_RESET_HOST'] || 'www.fan.link'}/#{person.product.internal_name}/#{person.name}",
        name: person.name,
        course_name: certcourse_page.certcourse.short_name
      },
      attachments: [{
                      content: File.read(Paperclip.io_adapters.for(certcourse_page.download_file_page.document).path),
                      name: certcourse_page.download_file_page.document_file_name,
                      type: certcourse_page.download_file_page.document_content_type
                    }],
      to: { email: person.email, name: person.name }
    )
  end

  def send_certificate(person, person_certificate, email)
    to_email = email.nil? ? person.email : email
    mandrill_mail(
      template: "test-certificate",
      subject: "%{name} - Your certificate" % { name: person.name },
      vars: {
        link: "https://#{ENV['PASSWORD_RESET_HOST'] || 'www.fan.link'}/#{person.product.internal_name}/#{person.name}",
        name: person_certificate.full_name,
        certificate_name: person_certificate.certificate.short_name
      },
      attachments: [{
        content: File.read(Paperclip.io_adapters.for(person_certificate.issued_certificate_pdf).path),
        name: person_certificate.issued_certificate_pdf_file_name,
        type: "application/pdf"
      }],
      to: { email: to_email, name: person.name }
     )
  end

  def send_assignee_certificate(person, assignee, person_certificate, email)
    to_email = email.nil? ? person.email : email
    mandrill_mail(
      template: "test-certificate",
      subject: "%{name} - The certificate you've requested" % { name: person.name },
      vars: {
        link: "https://#{ENV['PASSWORD_RESET_HOST'] || 'www.fan.link'}/#{person.product.internal_name}/#{assignee.name}",
        name: person_certificate.full_name,
        certificate_name: person_certificate.certificate.short_name
      },
      attachments: [{
        content: File.read(Paperclip.io_adapters.for(person_certificate.issued_certificate_pdf).path),
        name: person_certificate.issued_certificate_pdf_file_name,
        type: "application/pdf"
      }],
      to: { email: to_email, name: person.name }
     )
  end
private

  # def hostname
  #   MandrillMailer::config.default_url_options[:host]
  # end
end
