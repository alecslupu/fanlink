describe "Session (v1)" do
  before(:all) do
    @password = "badpassword"
    @person = create(:person, password: @password)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should log in a person with email from a regular account" do
      post "/session", params: { email_or_username: @person.email, password: @password, product: @person.product.internal_name }
      expect(response).to be_success
      expect(json["person"]).to eq(person_private_json(@person))
    end
    it "should log in a person with username from a regular account" do
      post "/session", params: { email_or_username: @person.username, password: @password, product: @person.product.internal_name }
      expect(response).to be_success
      expect(json["person"]).to eq(person_private_json(@person))
    end
    it "should not log in a person with wrong username from a regular account" do
      post "/session", params: { email_or_username: "wrongusername", password: @password, product: @person.product.internal_name }
      expect(response).to be_unprocessable
    end
    it "should not log in a person with wrong email from a regular account" do
      post "/session", params: { email_or_username: "wrongemail@example.com", password: @password, product: @person.product.internal_name }
      expect(response).to be_unprocessable
    end
    it "should log in a person via FB auth token" do
      tok = "1234"
      fbperson = create(:person, email: nil, facebookid: "12345")
      expect(Person).to receive(:for_facebook_auth_token).with(tok).and_return(fbperson)
      post "/session", params: { product: fbperson.product.internal_name, facebook_auth_token: tok }
      expect(response).to be_success
      expect(json["person"]).to eq(person_private_json(fbperson))
    end
    it "should not log in a person without a product" do
      post "/session", params: { email_or_username: @person.email, password: @password }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("must supply a valid product")
    end
    it "should not log in a person with a bad product" do
      post "/session", params: { email_or_username: @person.email, password: @password, product: "idonotexist" }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("must supply a valid product")
    end
    it "should not log in a person via bad FB auth token" do
      tok = "1234"
      fbperson = create(:person, email: nil, facebookid: "12345")
      expect(Person).to receive(:for_facebook_auth_token).with(tok).and_return(nil)
      post "/session", params: { product: fbperson.product.internal_name, facebook_auth_token: tok }
      expect(response).to have_http_status(:service_unavailable)
    end
  end

  describe "#destroy" do
    it "should log you out" do
      login_as(@person)
      delete "/session"
      expect(response).to be_success
    end
  end

  describe "#index" do
    it "should check a valid session" do
      login_as(@person)
      get "/session"
      expect(json["person"]).to eq(person_private_json(@person))
    end
    it "should 404 with no session" do
      logout
      get "/session"
      expect(response).to be_not_found
    end

  end
end
