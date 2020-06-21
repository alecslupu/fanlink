# frozen_string_literal: true

class Api::V1::PasswordResetsController < ApiController
  skip_before_action :require_login, :set_product

  # **
  # @api {post} /people/password_forgot Initiate a password reset.
  # @apiName CreatePasswordReset
  # @apiGroup People
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to initiate a password reset. Product and email or username required. If email or username
  # is not found, password reset will fail silently.
  #
  # @apiParam (body) {String} product
  #   Internal name of product
  # @apiParam (body) {String} email_or_username
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
  # *

  def create
    logout
    product = person = nil
    if params[:product].present?
      product = Product.find_by(internal_name: params[:product])
    end
    if product.present?
      set_product
      person = Person.can_login?(params[:email_or_username])
      if person
        person.set_password_token!
        person.send_password_reset_email
      end
      # Tell the user instructions have been sent whether or not email was found.
      # This is to not leak information about which emails exist in the system.
      render json: { message: "Reset password instructions have been sent to your email, if it exists in our system" }, status: :ok
    else
      render_error(_("Required parameter missing."))
    end
  end

  # **
  # @api {post} /people/password_reset Completes a password reset.
  # @apiName UpdatePasswordReset
  # @apiGroup People
  # @apiVersion 1.0.0
  #
  # @apiDescription
  #   This is used to complete a password reset. It takes a form submitted from fan.link
  #
  # @apiParam (body) {String} token
  #   Token from email link
  # @apiParam (body) {String} password
  #   The new password.
  #
  # @apiSuccessExample {json} Success-Response:
  #     HTTP/1.1 200 Ok; or
  #     HTTP/1.1 422 Unprocessable
  #     "errors": { //if token/person not found or password bad
  #       "...be better blah blah...."
  #     }
  # *

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
    errors.push((_("Missing password resetting token."))) if !token
    errors.push((_("Missing password."))) if !password
    errors.push((_("Unknown password resetting token."))) if token && !person

    if errors.empty?
      yield person, password
    else
      render_error(errors)
    end
  end
end
