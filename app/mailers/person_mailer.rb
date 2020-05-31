# frozen_string_literal: true
class PersonMailer < ApplicationMailer

  def onboarding
    @person = Person.find(params[:id])

    email = Static::SystemEmail.where(public: true, product_id: @person.product_id, slug: "onboarding").first!

    mail_params = {
      from:     "#{email.from_name} <#{email.from_email}>" ,
      reply_to: "support@flink.top" ,
      to: "#{@person.name} <#{@person.email}>",
      subject: email.subject
    }
    mail(mail_params) do |format|
      format.html  { render inline: ERB.new(email.html_template).result(binding) }
      format.text  { render inline: ERB.new(email.text_template).result(binding) }
    end
  end

  def reset_password
    @person = Person.find(params[:id])

    email = Static::SystemEmail.where(public: true, product_id: @person.product_id, slug: "password-reset").first!

    mail_params = {
      from:     "#{email.from_name} <#{email.from_email}>" ,
      reply_to: "support@flink.top" ,
      to: "#{@person.name} <#{@person.email}>",
      subject: email.subject
    }

    @link = "https://#{ENV['PASSWORD_RESET_HOST'] || 'www.fan.link'}/#{@person.product.internal_name}/reset_password?token=#{@person.reset_password_token}"
    @name = @person.name

    mail(mail_params) do |format|
      format.html  { render inline: ERB.new(email.html_template).result(binding) }
      format.text  { render inline: ERB.new(email.text_template).result(binding) }
    end
  end

  def send_downloaded_file
    @person = Person.find(params[:id])
    @certcourse_page = CertcoursePage.find(params[:certcourse_page_id])

    email = Static::SystemEmail.where(public: true, product_id: @person.product_id, slug: "document-download").first!

    mail_params = {
      from:     "#{email.from_name} <#{email.from_email}>" ,
      reply_to: "support@flink.top" ,
      to: "#{@person.name} <#{@person.email}>",
      subject: email.subject
    }

    @link = "https://#{ENV['PASSWORD_RESET_HOST'] || 'www.fan.link'}/#{@person.product.internal_name}/#{@person.name}"
    @course_name = @certcourse_page.certcourse.short_name

    attachments.inline[@certcourse_page.download_file_page.document_file_name] = File.read(Paperclip.io_adapters.for(@certcourse_page.download_file_page.document).path)

    mail(mail_params) do |format|
      format.html  { render inline: ERB.new(email.html_template).result(binding) }
      format.text  { render inline: ERB.new(email.text_template).result(binding) }
    end
  end

  def send_certificate
    @person = Person.find(params[:id])
    @person_certificate = PersonCertificate.find(params[:person_certificate])
    @email = params[:email]

    email = Static::SystemEmail.where(public: true, product_id: @person.product_id, slug: "download-certificate").first!
    @link = "https://#{ENV['PASSWORD_RESET_HOST'] || 'www.fan.link'}/#{@person.product.internal_name}/#{@person.name}"

    attachments.inline[@person_certificate.issued_certificate_pdf_file_name] = File.read(Paperclip.io_adapters.for(@person_certificate.issued_certificate_pdf).path)

    mail_params = {
      from:     "#{email.from_name} <#{email.from_email}>" ,
      reply_to: "support@flink.top" ,
      to: @email.presence || "#{@person.name} <#{@person.email}>",
      subject: email.subject
    }

    mail(mail_params) do |format|
      format.html  { render inline: ERB.new(email.html_template).result(binding) }
      format.text  { render inline: ERB.new(email.text_template).result(binding) }
    end
  end

  def send_assignee_certificate
    @person = Person.find(params[:person])
    @ssignee = Person.find(params[:assignee])
    @person_certificate = PersonCertificate.find(params[:person_certificate])
    @email = params[:email]

    email = Static::SystemEmail.where(public: true, product_id: @person.product_id, slug: "assignee-certificate").first!
    @link = "https://#{ENV['PASSWORD_RESET_HOST'] || 'www.fan.link'}/#{@person.product.internal_name}/#{@person.name}"

    attachments.inline[@person_certificate.issued_certificate_pdf_file_name] = @person_certificate.issued_certificate_pdf.download

    mail_params = {
      from:     "#{email.from_name} <#{email.from_email}>" ,
      reply_to: "support@flink.top" ,
      to: @email.presence || "#{@person.name} <#{@person.email}>",
      subject:  email.subject % { name: @person.name.presence || @person.product.name }
    }

    mail(mail_params) do |format|
      format.html  { render inline: ERB.new(email.html_template).result(binding) }
      format.text  { render inline: ERB.new(email.text_template).result(binding) }
    end
  end
end
