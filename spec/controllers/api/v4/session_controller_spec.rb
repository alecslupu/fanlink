# frozen_string_literal: true

require "spec_helper"

RSpec.describe Api::V4::SessionController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    pending
  end

  describe "POST create" do
    it "should return the correct response when providing correct credentials" do
      ActsAsTenant.without_tenant do
        person = create(:person, password: "correctpassword")
        post :create, params: { email_or_username: person.email, password: "correctpassword", product: person.product.internal_name }
        expect(Person.find(person.id)).to exist_in_database
        expect(response).to have_http_status(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["person"]["id"]).to include(person.id.to_s)
        expect(parsed_response["person"]["name"]).to include(person.name)
        expect(parsed_response["person"]["email"]).to include(person.email)
      end
    end

    it "should not login person with wrong password provided" do
      ActsAsTenant.without_tenant do
        person = create(:person)
        post :create, params: { email_or_username: person.email, password: "wrongpassword", product: person.product.internal_name }
        expect(response).to have_http_status(422)
        expect(json["errors"]).to include("Invalid login.")
      end
    end

    it "should not login person with wrong password provided" do
      ActsAsTenant.without_tenant do
        person = create(:person, password: "correctpassword")
        post :create, params: { email_or_username: person.email, password: "correctpassword", product: "wrongname" }
        expect(response).to have_http_status(422)
        expect(json["errors"]).to include("You must supply a valid product")
      end
    end

    it "returns unauthorized(code 401) for an unauthorized person" do
      person = create(:person, password: "password", authorized: false)
      post :create, params: { email_or_username: person.email, password: "password", product: person.product.internal_name }

      expect(response).to have_http_status(401)
      expect(json["errors"]).to include("This account is not authorized.")
    end
  end

  describe "POST token" do
    it "should return the correct response when providing correct credentials" do
      ActsAsTenant.without_tenant do
        person = create(:person, password: "correctpassword")
        post :token, params: { email_or_username: person.email, password: "correctpassword", product: person.product.internal_name }
        expect(response).to have_http_status(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["person"]["id"]).to include(person.id.to_s)
        expect(parsed_response["person"]["name"]).to include(person.name)
        expect(parsed_response["person"]["email"]).to include(person.email)
      end
    end

    it "should not login person with wrong password provided" do
      ActsAsTenant.without_tenant do
        person = create(:person)
        post :token, params: { email_or_username: person.email, password: "wrongpassword", product: person.product.internal_name }
        expect(response).to have_http_status(422)
        expect(json["errors"]).to include("Invalid login.")
      end
    end

    it "should not login person with wrong password provided" do
      ActsAsTenant.without_tenant do
        person = create(:person, password: "correctpassword")
        post :token, params: { email_or_username: person.email, password: "correctpassword", product: "wrongname" }
        expect(response).to have_http_status(422)
        expect(json["errors"]).to include("You must supply a valid product")
      end
    end

    it "returns unauthorized(code 401) for an unauthorized person" do
      person = create(:person, password: "password", authorized: false)
      post :create, params: { email_or_username: person.email, password: "password", product: person.product.internal_name }

      expect(response).to have_http_status(401)
      expect(json["errors"]).to include("This account is not authorized.")
    end
  end
end

