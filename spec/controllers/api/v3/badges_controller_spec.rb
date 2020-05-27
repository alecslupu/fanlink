# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V3::BadgesController, type: :controller do
  describe 'GET index' do
    it 'returns all badges with their attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:badge, 3)
        get :index
        expect(response).to have_http_status(200)
        expect(json['badges'].size).to eq(3)
        json['badges'].each do |badge|
          expect(badge['badge']['picture_url']).not_to eq(nil)
        end
      end
    end
  end

  describe 'POST create' do
    it "creates a badge with attachment when it's valid" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        post :create, params: {
          badge: {
            product_id: person.product.id,
            action_type_id: create(:action_type).id,
            internal_name: 'act1',
            picture: fixture_file_upload('images/better.png', 'image/png')
          }
        }

        expect(response).to have_http_status(200)
        expect(Badge.last.picture.attached?).to be_truthy
        expect(json['badge']['picture_url']).to include(Rails.application.secrets.cloudfront_url)
      end
    end
  end

  describe 'PUT update' do
    it "updates a badge's attachment" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        badge = create(:badge)

        put :update, params: {
          id: badge.id,
          badge: {
            picture: fixture_file_upload('images/better.png', 'image/png')
          }
        }

        expect(response).to have_http_status(200)
        expect(Badge.last.picture.attached?).to be_truthy
        expect(json['badge']['picture_url']).to include(Rails.application.secrets.cloudfront_url)
      end
    end
  end
  describe 'GET show' do
    it 'returns the badge with the attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        badge = create(:badge)
        get :show, params: { id: badge.id }
        expect(response).to have_http_status(200)

        expect(json['badge']['picture_url']).not_to eq(nil)
      end
    end
  end
end
