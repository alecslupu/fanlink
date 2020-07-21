# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/user_mailer/onboarding.html?locale=en&product=caned
class PersonMailerPreview < ActionMailer::Preview
  def onboarding
    product = Product.where(internal_name: params[:product]).last || Product.last

    PersonMailer.with(id: product.people.last.id).onboarding
  end

  def reset_password
    product = Product.where(internal_name: params[:product]).last || Product.last
    PersonMailer.with(id: product.people.last.id).reset_password
  end

  def send_downloaded_file
    product = Product.where(internal_name: params[:product]).last || Product.last

    certcourse_page = DownloadFilePage.where(product_id: product.id).first.course_page
    person = certcourse_page.course.people.first

    PersonMailer.with(
      id: person.id,
      certcourse_page_id: certcourse_page.id
    ).send_downloaded_file
  end

  def send_certificate
    product = Product.where(internal_name: params[:product]).last || Product.last

    person_certificate = PersonCertificate
                         .joins(:person)
                         .where(people: { product_id: product.id })
                         .where.not(issued_date: nil)
                         .first

    PersonMailer.with(
      id: person_certificate.person.id,
      person_certificate: person_certificate.id
    ).send_certificate
  end

  def send_assignee_certificate
    product = Product.where(internal_name: params[:product]).last || Product.last

    person_certificate = PersonCertificate
                         .joins(:person)
                         .where(people: { product_id: product.id })
                         .where.not(issued_date: nil)
                         .first

    PersonMailer.with(
      person: product.people.last.id,
      assignee: person_certificate.person.id,
      person_certificate: person_certificate.id,
      email: 'random@flink.to'
    ).send_assignee_certificate
  end
end
