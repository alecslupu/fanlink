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
  end


  # TODO: auto-generated
  describe "POST create" do
    it "should create a person with a picture attached if added" do
      product = create(:product)
      ActsAsTenant.with_tenant(product) do
        expect_any_instance_of(Person).to receive(:do_auto_follows)
        username = "newuser#{Time.now.to_i}"
        email = "#{username}@example.com"
        post :create, params:
          { product: product.internal_name,
            person: {
              username: username,
              email: email,
              password: "password",
              gender: "male",
              birthdate: "2019-01-02",
              city: "Las Vegas",
              country_code: "us",
              picture: fixture_file_upload("images/better.png", "image/png")
            }
          }
        expect(response).to be_successful
        expect(json["person"]["picture_url"]).to_not eq(nil)
        expect(Person.last.picture.exists?).to eq(true)
      end
    end
  end

  # TODO: auto-generated
  describe "GET index" do
    it "should return the people objects with their attached picture" do
      person = create(:person, picture: fixture_file_upload("images/better.png", "image/png"))
      ActsAsTenant.with_tenant(person.product) do
        create_list(:person,3, picture: fixture_file_upload("images/better.png", "image/png"))

        login_as(person)
        get :index

        expect(response).to be_successful
        expect(json["people"].count).to eq(3) #current user is not included
        json["people"].each do |person|
          expect(person["picture_url"]).to_not eq(nil)
        end

        Person.all.each do |person|
          expect(person.picture.exists?).to eq(true)
        end
      end
    end
  end

  # TODO: auto-generated
  describe "GET show" do
    it "should return the people object with their attached picture" do
      person = create(:person, picture: fixture_file_upload("images/better.png", "image/png"))
      ActsAsTenant.with_tenant(person.product) do
        create_list(:person,3, picture: fixture_file_upload("images/better.png", "image/png"))

        login_as(person)
        get :show ,params: { id: person.id }

        expect(response).to be_successful
        expect(json["person"]["picture_url"]).to_not eq(nil)
        expect(Person.last.picture.exists?).to eq(true)
      end
    end
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
