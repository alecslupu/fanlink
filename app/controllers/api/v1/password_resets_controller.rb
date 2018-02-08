class Api::V1::PasswordResetsController < ApiController
  skip_before_action :require_login, :set_product

  #**
  # @api {post} /password_resets Initiate a password reset.
  # @apiName CreatePasswordReset
  # @apiGroup People
  #
  # @apiDescription
  #   This is used to initiate a password reset. Product_id and email or username required. If email or username
  # is not found, password reset will fail silently.
  #
  # @apiParam {Integer} product_id
  #   Internal name of product
  # @apiParam {String} email_or_username
  #   The person's email or username.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok
  #     "message": {
  #       "Reset password instructions have been sent to your email, if it exists in our system"
  #     }, or
  #     HTTP/1.1 422 Unprocessable
  #     "errors": { //if product not found
  #       "Required parameter missing."
  #     }
  #*
  def create
    product = person = nil
    if params[:product_id].to_i > 0
      product = Product.find_by(id: params[:product_id].to_i)
    end
    if product.present?
      person = Person.can_login?(params[:email_or_username])
      if person
        person.set_password_token!
        PersonMailer.reset_password(person).deliver_now
      end
      # Tell the user instructions have been sent whether or not email was found.
      # This is to not leak information to attackers about which emails exist in the system.
      render json: { message: "Reset password instructions have been sent to your email, if it exists in our system" }, status: :ok
    else
      render json: { errors: "Required parameter missing." }, status: :unprocessable_entity
    end
  end

  # This action fires when the user has sent the reset password form (which is a static form on fan.link).
  def update
    grab_password_reset_stuff_and do |person, password|
      if person.reset_password_to(password)
        head :ok
      else
        render_error(person.errors)
      end
    end
  end

private

  def grab_password_reset_stuff_and
    token    = params[:token   ].to_s.strip.presence
    password = params[:password].to_s.strip.presence
    person   = Person.find_by(reset_password_token: token) if token
    errors   = [ ]

    errors.push(_("Missing password resetting token.")) if !token
    errors.push(_("Missing password.")) if !password
    errors.push(_("Unknown password resetting token.")) if token && !person

    if errors.empty?
      yield person, password
    else
      render json: { errors: errors }, status: :unprocessable_entity
    end
  end
end
