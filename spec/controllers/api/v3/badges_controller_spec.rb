require "rails_helper"

RSpec.describe Api::V3::BadgesController, type: :controller do

  # TODO: auto-generated
  describe "GET index" do
    pending
  end

  describe "POST create" do
    it "should create a badge with attachment when it's valid" do
      person = create(:person, role: :admin)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        post :create, params: {
          badge: {
            product_id: person.product.id,
            action_type_id: create(:action_type).id,
            internal_name: "act1",
            picture: fixture_file_upload("images/better.png", "image/png")
          }
        }

        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(Badge.first.picture.exists?).to eq(true)
        expect(parsed_response["badge"]["picture_url"]).to include("better.png")
      end
    end
  end

  describe "PUT update" do
    it "should update a badge's attachment" do
      person = create(:person, role: :admin)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        badge = create(:badge)

        put :update, params: {
          id: badge.id,
          badge: {
            picture: fixture_file_upload("images/better.png", "image/png")
          }
        }

        parsed_response = JSON.parse(response.body)
        expect(response).to have_http_status(200)
        expect(Badge.first.picture.exists?).to eq(true)
        expect(parsed_response["badge"]["picture_url"]).to include("better.png")
      end
    end
  end

  # TODO: auto-generated
  describe "GET show" do
    pending
  end

  # TODO: auto-generated
  describe "DELETE destroy" do
    pending
  end
end
