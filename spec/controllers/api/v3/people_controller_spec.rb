require "rails_helper"

RSpec.describe Api::V3::PeopleController, type: :controller do

  describe "#change_password" do
    it "should change the current users password" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password,  params: { id: person.id, person: { current_password: current, new_password: new_password } }
        expect(response).to be_successful
        expect(person.reload.valid_password?(new_password)).to be_truthy
      end
    end
    it "should not change the current users password to one that is too short" do
      current = "secret"
      new_password = "short"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password,  params: { id: person.id, person: { current_password: current, new_password: new_password } }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Password must be at least 6 characters in length.")
      end
    end
    it "should not change the current users password if wrong password given" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password,  params: { id: person.id, person: { current_password: "wrongpassword", new_password: new_password } }
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("The password is incorrect")
      end
    end
    it "should not change the user password if not logged in" do
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        patch :change_password,  params: { id: person.id, person: { current_password: current, new_password: new_password } }
        expect(response).to be_unauthorized
        expect(person.reload.valid_password?(current)).to be_truthy
      end
    end
    it "should not change the password if wrong user id in url" do
      pers = create(:person)
      current = "secret"
      new_password = "newsecret"
      person = create(:person, password: current)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        patch :change_password,  params: { id: pers.id,  person: { current_password: current, new_password: new_password } }
        expect(response).to be_not_found
        expect(person.reload.valid_password?(current)).to be_truthy
      end
    end
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
  describe "POST create" do
    pending
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
  describe "GET public" do
    pending
  end

  # TODO: auto-generated
  describe "PUT update" do
    pending
  end

  # TODO: auto-generated
  describe "DELETE destroy" do
    pending
  end

  # TODO: auto-generated
  describe "GET interests" do
    pending
  end
end
