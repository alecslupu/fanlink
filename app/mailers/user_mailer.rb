class UserMailer < ApplicationMailer

  def onboarding
    person = Person.find(params[:id])

    email = Static::SystemEmail.where(public: true, product_id: person.product_id, slug: :onboarding).first!

    # html_template = Static::SystemEmail.where(public: true,product_id: person.product_id, slug: "html-onboarding").first!
    # text_template = StaticContent.where(product_id: person.product_id, slug: "text-onboarding").first!

    # mandrill_mail(
    #   template: "#{ person.product.internal_name }-onboarding",
    #   to: { email: person.email, name: person.name }
    # )
    mail_params = {
      from:     "#{email.from_name} <#{email.from_email}>" ,
      reply_to: "support@flink.top" ,
      to: person.email,
      subject: email.subject
    }
    mail(mail_params) do |format|
      format.html  { render inline: ERB.new(email.html_template).result(binding) }
      format.text  { render inline: ERB.new(email.text_template).result(binding) }
    end
  end
end
