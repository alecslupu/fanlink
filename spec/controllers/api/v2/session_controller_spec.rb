require "spec_helper"

RSpec.describe Api::V2::SessionController, type: :controller do
  before(:each) do
    logout
  end

  describe "#index" do
    it "should check a valid session" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index
      end
      expect(assigns(:person)).to eq(person)
      expect(response).to have_http_status(200)
    end
    it "should 404 with no session" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        get :index, params: { format: :json }
      end
      expect(assigns(:person)).not_to eq(person)
      expect(response).to have_http_status(404)
    end
  end

  describe "#create" do
    it "should log in a person with email from a regular account" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post :create, params: { email_or_username: person.email, password: "badpassword", product: person.product.internal_name }
      end
      expect(response).to have_http_status(200)
      expect(person_private_json(json["person"])).to be_truthy
    end
    it "should log in a person with username from a regular account" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post :create, params: { email_or_username: person.username, password: "badpassword", product: person.product.internal_name }
      end
      expect(response).to have_http_status(200)
      expect(person_private_json(json["person"])).to be_truthy
    end
    it "should not log in a person with wrong username from a regular account" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post :create, params: { email_or_username: "wrongusername", password: "badpassword", product: person.product.internal_name }
      end
      expect(response).to have_http_status(422)
    end
    it "should not log in a person with wrong email from a regular account" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post :create, params: { email_or_username: "wrongemail@example.com", password: "badpassword", product: person.product.internal_name }
      end
      expect(response).to have_http_status(422)
    end

    it "should log in a person via FB auth token" do
      tok = "1234"
      fbperson = create(:person, email: nil, facebookid: "12345")
      expect(Person).to receive(:for_facebook_auth_token).with(tok).and_return(fbperson)
      ActsAsTenant.with_tenant(fbperson.product) do
        post :create, params: { product: fbperson.product.internal_name, facebook_auth_token: tok }
      end
      expect(response).to have_http_status(200)
      expect(person_private_json(json["person"])).to be_truthy
    end
    it "should not log in a person without a product" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post :create, params: { email_or_username: person.email, password: "badpassword" }
      end
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("You must supply a valid product")
    end
    it "should not log in a person with a bad product" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        post :create, params: { email_or_username: person.email, password: "badpassword", product: "idonotexist" }
      end
      expect(response).to have_http_status(422)
      expect(json["errors"]).to include("You must supply a valid product")
    end
    it "should not log in a person via bad FB auth token" do
      tok = "1234"
      fbperson = create(:person, email: nil, facebookid: "12345")
      expect(Person).to receive(:for_facebook_auth_token).with(tok).and_return(nil)
      ActsAsTenant.with_tenant(fbperson.product) do
        post :create, params: { product: fbperson.product.internal_name, facebook_auth_token: tok }
      end
      expect(response).to have_http_status(:service_unavailable)
    end
  end

  describe "#destroy" do
    it "should log you out" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        delete :destroy
      end
      expect(response).to have_http_status(200)
    end
  end
end
