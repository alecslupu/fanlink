require "rails_helper"

RSpec.describe Api::V3::BadgesController, type: :controller do

  describe "GET index" do
    it "should return all badges attachment with their images" do
      person = create(:person, role: :admin)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:badge,3)
        get :index
        expect(response).to have_http_status(200)
        expect(json["badges"].size).to eq(3)
        json["badges"].each do |badge|
          expect(Badge.find(badge["badge"]["id"]).picture.exists?).to eq(true)
        end
      end
    end
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

        expect(response).to have_http_status(200)
        expect(Badge.last.picture.exists?).to eq(true)
        expect(json["badge"]["picture_url"]).to include("better.png")
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

        expect(response).to have_http_status(200)
        expect(Badge.last.picture.exists?).to eq(true)
        expect(json["badge"]["picture_url"]).to include("better.png")
      end
    end
  end

  describe "GET show" do
    it "should return all badges attachment with their images" do
      person = create(:person, role: :admin)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        badge = create(:badge)
        get :show, params: { id: badge.id }
        expect(response).to have_http_status(200)
        expect(Badge.last.picture.exists?).to eq(true)
      end
    end
  end

  # TODO: auto-generated
  describe "DELETE destroy" do
    pending
  end
end
