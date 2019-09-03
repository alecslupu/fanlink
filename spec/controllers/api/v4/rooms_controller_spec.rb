require "rails_helper"

RSpec.describe Api::V4::RoomsController, type: :controller do

  # TODO: auto-generated
  describe "GET index" do
    it "should return active public rooms with their attached pictures" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:room, 3, public: true, status: :active, picture: fixture_file_upload("images/better.png", "image/png"))
        get :index

        expect(response).to be_successful
        expect(json["rooms"].size).to eq(3)
        json["rooms"].each do |room|
          expect(room["picture_url"]).to_not eq(nil)
        end
      end
    end
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
end
