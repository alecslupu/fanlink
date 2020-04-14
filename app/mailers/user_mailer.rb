class UserMailer < ApplicationMailer

  def onboarding
    person = Person.find(params[:id])

    email = Static::SystemEmail.where(published: true, product_id: person.product_id, name: :onboarding).first!


    html_template = Static::SystemEmail.where(product_id: person.product_id, slug: "html-onboarding").first!
    text_template = StaticContent.where(product_id: person.product_id, slug: "text-onboarding").first!

    # mandrill_mail(
    #   template: "#{ person.product.internal_name }-onboarding",
    #   to: { email: person.email, name: person.name }
    # )
    mail_params = {
      from:     -> { "foo@flink.to" },
      reply_to: -> { "support@flink.top" },
      to: person.email,
      subject: ""
    }
    mail(mail_params) do |format|
      format.html  { render inline: ERB.new(html_template).result(binding) }
      format.text  { render text: ERB.new(text_template).result(binding) }
    end
  end
end
