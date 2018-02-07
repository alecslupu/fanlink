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
        post "/password_resets", params: { product_id: person.product.id.to_s, email_or_username: email }
      }.to change { MandrillMailer.deliveries.count }.by(1)
      expect(response).to be_success
    end
  end
end