require 'rails_helper'

RSpec.describe Api::V1::PasswordResetsController, type: :controller do
  describe "#create" do
    it "should accept valid password reset parameters with email and send the email"
    it "should accept password reset parameters with unfound email and not send the email"
    it "should accept valid username parameter and send the email"
    it "should accept password reset parameters with unfound username and not send the email"
    it "should not process if missing product"
  end

  describe "#update" do
    it "should accept valid token and password and reset password"
    it "should not accept invalid token"
    it "should not accept valid token but invalid password"
  end
end
