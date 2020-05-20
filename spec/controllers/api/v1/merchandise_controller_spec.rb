# frozen_string_literal: true
require "spec_helper"

RSpec.describe Api::V1::MerchandiseController, type: :controller do
  describe "#index" do
    it "should get the available merchandise in priority order" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expected = create_list(:merchandise, 2)
        get :index
        expect(response).to be_successful
        expect(json["merchandise"].count).to eq(expected.size)
        expect(merchandise_json(json["merchandise"].first)).to be_truthy
        expect(merchandise_json(json["merchandise"].last)).to be_truthy
      end
    end
    it "should not get the available merchandise if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        get :index
        expect(response).to have_http_status(401)
      end
    end
    it 'returns all merchandises with their attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:merchandise, 3, picture: fixture_file_upload('images/better.png', 'image/png'))
        get :index

        expect(response).to have_http_status(200)
        expect(json['merchandise'].size).to eq(3)
        json['merchandise'].each do |merchandise|
          expect(merchandise['picture_url']).not_to eq(nil)
        end
      end
    end
  end

  describe "#show" do
    it "should get a single piece of available merchandise" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        merchandise = create(:merchandise)
        get :show, params: { id: merchandise.id }
        expect(response).to have_http_status(200)
        expect(merchandise_json(json["merchandise"])).to be_truthy
      end
    end
    it "should not get the available merchandise if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        merchandise = create(:merchandise)
        get :show, params: { id: merchandise.id }
        expect(response).to have_http_status(401)
      end
    end
    it "should not get merchandise from a different product" do
      person = create(:person)
      merchandise = create(:merchandise, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :show, params: { id: merchandise.id }
        expect(response).to have_http_status(404)
      end
    end
    it 'returns the merchandise with the attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        merchandise = create(:merchandise, picture: fixture_file_upload('images/better.png', 'image/png'))
        get :show, params: { id: merchandise.id }
        expect(response).to have_http_status(200)

        expect(json['merchandise']['picture_url']).not_to eq(nil)
      end
    end
  end
end
