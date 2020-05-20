# frozen_string_literal: true
require "spec_helper"

RSpec.describe Api::V2::LevelsController, type: :controller do
  describe "#index" do
    it "should return all levels" do
      person = create(:person)
      create(:level, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        create_list(:level, 2)
        login_as(person)
        get :index
        expect(response).to have_http_status(200)
        expect(json["levels"].count).to eq(2)
        expect(level_json(json["levels"].first)).to be_truthy
        expect(level_json(json["levels"].last)).to be_truthy
      end
      # l1 = json["levels"].first
      # expect(json["levels"].first).to eq(level_json(level2))
      # expect(json["levels"].last).to eq(level_json(level1))
    end

    it 'returns all levels with their attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(
          :level,
          3,
          picture: fixture_file_upload('images/better.png', 'image/png')
        )

        get :index

        expect(response).to have_http_status(200)
        expect(json['levels'].size).to eq(3)
        json['levels'].each do |level|
          expect(level['picture_url']).not_to eq(nil)
          expect(Level.find(level['id']).picture.exists?).to eq(true)
        end
      end
    end
  end
end
