require "rails_helper"

RSpec.describe Api::V4::InterestsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
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

  describe "GET match" do
    it "gets all the people that have at least one of the interests, except current user" do

    end
  end
end

    it "should not change the current users password if it matches the current one" do
      password = "password"
      person = create(:person, password: password)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password,  params: { id: person.id, person: { current_password: password, new_password: password } }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("New password can't be identical to your current one")
      end
    end
