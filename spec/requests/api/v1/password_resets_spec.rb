describe "PasswordResets (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should accept valid password reset parameters with email and send the email" do
      email = "forgetful@example.com"
      person = create(:person, email: email)
      expect {
        post "/people/password_forgot", params: { product: person.product.internal_name, email_or_username: email }
      }.to change { MandrillMailer.deliveries.count }.by(1)
      expect(response).to be_success
      expect(person.reload.reset_password_token).not_to be_nil
      expect(email_sent(template: "#{person.product.internal_name}-password-reset",
                        to_values: { email: person.email, name: person.name },
                        merge_vars:  { link: "https://#{MandrillMailer::config.default_url_options[:host]}/#{person.product.internal_name}/reset_password?token=#{person.reset_password_token}",
                                       name: person.name })
      ).to_not be_nil
    end
    it "should accept password reset parameters with unfound email and not send the email" do
      email = "forgetful@example.com"
      person = create(:person, email: email)
      expect {
        post "/people/password_forgot", params: { product: person.product.internal_name, email_or_username: "really_forgetful@example.com" }
      }.to change { MandrillMailer.deliveries.count }.by(0)
      expect(response).to be_success
      expect(person.reload.reset_password_token).to be_nil
    end
    it "should accept valid username parameter and send the email" do
      username = "forgetful"
      person = create(:person, username: username)
      expect {
        post "/people/password_forgot", params: { product: person.product.internal_name, email_or_username: username }
      }.to change { MandrillMailer.deliveries.count }.by(1)
      expect(response).to be_success
      expect(person.reload.reset_password_token).not_to be_nil
      expect(email_sent(template: "#{person.product.internal_name}-password-reset",
                        to_values: { email: person.email, name: person.name },
                        merge_vars:  { link: "https://#{MandrillMailer::config.default_url_options[:host]}/#{person.product.internal_name}/reset_password?token=#{person.reset_password_token}",
                                       name: person.name })
      ).to_not be_nil
    end
    it "should accept password reset parameters with unfound username and not send the email" do
      username = "forgetful"
      person = create(:person, username: username)
      expect {
        post "/people/password_forgot", params: { product: person.product.internal_name, email_or_username: "really_forgetful" }
      }.to change { MandrillMailer.deliveries.count }.by(0)
      expect(response).to be_success
      expect(person.reload.reset_password_token).to be_nil
    end
    it "should not process if missing product" do
      email = "forgetful@example.com"
      person = create(:person, email: email)
      expect {
        post "/people/password_forgot", params: { product: "foofarmfizzle", email_or_username: email }
      }.to change { MandrillMailer.deliveries.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Required parameter missing")
    end
  end

  describe "#update" do
    it "should accept valid token and password and reset password" do
      person = create(:person, username: "forgetful_too")
      new_password = "super_secret"
      person.set_password_token!
      post "/people/password_reset", params: { token: person.reset_password_token, password: new_password }
      expect(response).to be_success
      expect(person.reload.valid_password?(new_password)).to be_truthy
    end
    it "should not accept invalid token" do
      post "/people/password_reset", params: { token: "garbage", password: "super_secret" }
      expect(response).to be_unprocessable
      expect(json["errors"].first).to include("Unknown password resetting token")
    end
    it "should not accept valid token but invalid password" do
      pw = "secret"
      person = create(:person, password: pw)
      person.set_password_token!
      post "/people/password_reset", params: { token: person.reset_password_token, password: "short" }
      expect(response).to be_unprocessable
      expect(json["errors"]["password"].first).to include("is too short")
      expect(person.valid_password?(pw)).to be_truthy
    end
  end
end
