require "spec_helper"

RSpec.describe Api::V4::PasswordResetsController, type: :controller do
  describe "#create" do
    it "should accept valid password reset parameters with email and send the email", :run_delayed_jobs do
      email = "forgetful@example.com"
      person = create(:person, email: email)
      ActsAsTenant.with_tenant(person.product) do
        expect {
          post :create, params: { product: person.product.internal_name, email_or_username: email }
        }.to change { MandrillMailer.deliveries.count }.by(1)
        expect(response).to be_successful
        expect(person.reload.reset_password_token).not_to be_nil
        expect(email_sent(template: "#{person.product.internal_name}-password-reset",
                          to_values: { email: person.email, name: person.name },
                          merge_vars: { link: "https://#{MandrillMailer.config.default_url_options[:host]}/#{person.product.internal_name}/reset_password?token=#{person.reset_password_token}",
                                       name: person.name, })).to_not be_nil
      end
    end
    it "should accept password reset parameters with unfound email and not send the email" do
      email = "forgetful@example.com"
      person = create(:person, email: email)
      ActsAsTenant.with_tenant(person.product) do
        expect {
          post :create, params: { product: person.product.internal_name, email_or_username: "really_forgetful@example.com" }
        }.to change { MandrillMailer.deliveries.count }.by(0)
        expect(response).to be_successful
        expect(person.reload.reset_password_token).to be_nil
      end
    end
    it "should accept valid username parameter and send the email", :run_delayed_jobs do
      username = "forgetful"
      person = create(:person, username: username)
      ActsAsTenant.with_tenant(person.product) do
        expect {
          post :create, params: { product: person.product.internal_name, email_or_username: username }
        }.to change { MandrillMailer.deliveries.count }.by(1)
        expect(response).to be_successful
        expect(person.reload.reset_password_token).not_to be_nil
        expect(email_sent(template: "#{person.product.internal_name}-password-reset",
                          to_values: { email: person.email, name: person.name },
                          merge_vars: { link: "https://#{MandrillMailer.config.default_url_options[:host]}/#{person.product.internal_name}/reset_password?token=#{person.reset_password_token}",
                                       name: person.name, })).to_not be_nil
      end
    end
    it "should accept password reset parameters with unfound username and not send the email" do
      username = "forgetful"
      person = create(:person, username: username)
      ActsAsTenant.with_tenant(person.product) do
        expect {
          post :create, params: { product: person.product.internal_name, email_or_username: "really_forgetful" }
        }.to change { MandrillMailer.deliveries.count }.by(0)
        expect(response).to be_successful
        expect(person.reload.reset_password_token).to be_nil
      end
    end
    it "should not process if missing product" do
      email = "forgetful@example.com"
      person = create(:person, email: email)
      ActsAsTenant.with_tenant(person.product) do
        expect {
          post :create, params: { product: "foofarmfizzle", email_or_username: email }
        }.to change { MandrillMailer.deliveries.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Required parameter missing.")
      end
    end
  end

  describe "#update" do
    it "should accept valid token and password and reset password" do
      person = create(:person, username: "forgetful_too")
      ActsAsTenant.with_tenant(person.product) do
        new_password = "super_secret"
        person.set_password_token!
        post :update, params: { token: person.reset_password_token, password: new_password }
        expect(response).to be_successful
        expect(person.reload.valid_password?(new_password)).to be_truthy
      end
    end
    it "should not accept invalid token" do
      person = create(:person, username: "forgetful_too")
      ActsAsTenant.with_tenant(person.product) do
        new_password = "super_secret"
        person.set_password_token!
        post :update, params: { token: "garbage", password: "super_secret" }
        expect(response).to be_unprocessable
        expect(json["errors"][0]).to include("Unknown password resetting token.")
      end
    end

    it "should not accept valid token but invalid password" do
      pw = "secret"
      person = create(:person, password: pw)
      ActsAsTenant.with_tenant(person.product) do
        person.set_password_token!
        post :update, params: { token: person.reset_password_token, password: "short" }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Password must be at least 6 characters in length.")
        expect(person.valid_password?(pw)).to be_truthy
      end
    end
  end
end
