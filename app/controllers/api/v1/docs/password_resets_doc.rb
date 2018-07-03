class Api::V1::Docs::PasswordResetsDoc < ApiDoc
  #**
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
  #*

  #**
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
  #*

  doc_tag name: 'PasswordResets', desc: "Password Reset"
  route_base 'api/v1/password_resets'
end
