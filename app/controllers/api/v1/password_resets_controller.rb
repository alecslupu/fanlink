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
    product = person= nil
    if params[:product_id].to_i > 0
      product = Product.find_by(id: params[:product_id].to_i)
    end
    if product.present?
      person = Person.can_login?(params[:email_or_username])
      # This line sends an email to the user with instructions on how to reset their password (a url with a random token)
      person.deliver_reset_password_instructions! if person
      # Tell the user instructions have been sent whether or not email was found.
      # This is to not leak information to attackers about which emails exist in the system.
      render json: { message: "Reset password instructions have been sent to your email, if it exists in our system" }, status: :ok
    else
      render json: { errors: "Required parameter missing." }, status: :unprocessable_entity
    end
  end

  # This action fires when the user has sent the reset password form.
  def update
    # @token = params[:id]
    # @user = User.load_from_reset_password_token(params[:id])
    #
    # if @user.blank?
    #   not_authenticated
    #   return
    # end
    #
    # # the next line makes the password confirmation validation work
    # @user.password_confirmation = params[:user][:password_confirmation]
    # # the next line clears the temporary token and updates the password
    # if @user.change_password!(params[:user][:password])
    #   redirect_to(root_path, :notice => 'Password was successfully updated.')
    # else
    #   render :action => "edit"
    # end
  end
end