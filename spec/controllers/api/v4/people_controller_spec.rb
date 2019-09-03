require "rails_helper"

RSpec.describe Api::V4::PeopleController, type: :controller do

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
