require "rails_helper"

RSpec.describe Api::V4::PeopleController, type: :controller do

  # TODO: auto-generated
  describe "GET index" do
    it "should return the people objects with their attached picture" do
      person = create(:person, picture: fixture_file_upload("images/better.png", "image/png"))
      ActsAsTenant.with_tenant(person.product) do
        create_list(:person,3, picture: fixture_file_upload("images/better.png", "image/png"))

        login_as(person)
        get :index

        expect(response).to be_successful
        expect(json["people"].count).to eq(3)  #current user is not included
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
        expect(json["person"]).to_not eq(nil)
        expect(Person.last.picture.exists?).to eq(true)
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
        expect(json["person"]).to_not eq(nil)
        expect(Person.last.picture.exists?).to eq(true)
      end
    end
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
