# Preview all emails at http://localhost:3000/rails/mailers/user_mailer/onboarding.html?locale=en&product=caned
class UserMailerPreview < ActionMailer::Preview
  def onboarding
    product = Product.where(internal_name: params[:product]).last || Product.last

    UserMailer.with(id: product.people.last.id).onboarding
  end
end
