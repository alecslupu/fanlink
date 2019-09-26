require "rails_helper"

RSpec.describe Api::V4::PeopleController, type: :controller do

  describe "#change_password" do
    it "should not change the current users password if it matches the current one" do
      password = "password"
      person = create(:person, password: password)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password,  params: { id: person.id, person: { current_password: password, new_password: password } }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("New password can't be identical to the current one")
      end
    end
  end

  # TODO: auto-generated
  describe "GET index" do
    pending
  end

  # TODO: auto-generated
  describe "GET show" do
    pending
  end

  # TODO: auto-generated
  describe "POST create" do
    pending
  end

  # TODO: auto-generated
  describe "PUT update" do
    pending
  end

  # TODO: auto-generated
  describe "GET stats" do
    pending
  end

  # TODO: auto-generated
  describe "GET send_certificate" do
    pending
  end
end
