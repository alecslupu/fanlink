# frozen_string_literal: true
require "spec_helper"

RSpec.describe Api::V2::BadgesController, type: :controller do
  describe "#index" do
    it "should return all badges for a passed in person" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        badge1 = create(:badge, action_requirement: 1)
        badge2 = create(:badge, action_requirement: 4)
        person.badge_awards.create(badge: badge1)
        person.badge_actions.create(action_type: badge2.action_type)
        login_as(person)
        get :index, params: { person_id: person.id }
        expect(response).to have_http_status(200)
        expect(json["badges"].count).to eq(2)
        sb = json["badges"].first
        expect(sb["badge_action_count"]).to eq(0)
        expect(badge_json(sb["badge"])).to be_truthy
        fb = json["badges"].last
        expect(fb["badge_action_count"]).to eq(1)
        expect(badge_json(fb["badge"])).to be_truthy
      end
    end
    it "should return 404 for non-existent passed in person" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: { person_id: (person.id + 1) }
        expect(response).to have_http_status(404)
      end
    end
    it "should return 404 for passed in person from another product" do
      person = create(:person)
      person2 = create(:person, product: create(:product))
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :index, params: { person_id: person2.id }
        expect(response).to have_http_status(404)
      end
    end
    it 'returns all badges with their attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        badge1 = create(:badge, action_requirement: 1)
        badge2 = create(:badge, action_requirement: 4)
        person.badge_awards.create(badge: badge1)
        person.badge_actions.create(action_type: badge2.action_type)

        get :index, params: { person_id: person.id }
        expect(response).to have_http_status(200)
        expect(json['badges'].size).to eq(2)
        json['badges'].each do |badge|
          expect(badge['badge']['picture_url']).not_to eq(nil)
        end
      end
    end
  end
end
