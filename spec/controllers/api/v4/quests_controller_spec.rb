# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Api::V4::QuestsController, type: :controller do
  describe 'GET index' do
    it 'returns all quests with their attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:quest, 3, picture: fixture_file_upload('images/better.png', 'image/png'))
        get :index

        expect(response).to be_successful
        expect(json['quests'].size).to eq(3)
        json['quests'].each do |quest|
          expect(quest['picture_url']).not_to eq(nil)
        end
      end
    end
  end

  describe 'GET show' do
    it 'returns the quest with the attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        quest = create(:quest, picture: fixture_file_upload('images/better.png', 'image/png'))
        get :show, params: { id: quest.id }

        expect(response).to be_successful
        expect(json['quest']['picture_url']).not_to eq(nil)
      end
    end
  end

  describe 'POST create' do
    it "creates a quest with attachment when it's valid" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        post :create, params: {
          quest: {
            product_id: person.product.id,
            internal_name: 'A name',
            description: 'desc',
            starts_at: DateTime.now,
            name: 'name',
            picture: fixture_file_upload('images/better.png', 'image/png')
          }
        }

        expect(response).to be_successful
        expect(Quest.last.picture.attached?).to be_truthy
        expect(json['quest']['picture_url']).to be_present

      end
    end
  end

  describe 'PUT update' do
    it "updates a quest's attachment" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        quest = create(:quest)

        put :update, params: {
          id: quest.id,
          quest: {
            picture: fixture_file_upload('images/better.png', 'image/png')
          }
        }

        expect(response).to be_successful
        expect(Quest.last.picture.attached?).to be_truthy
        expect(json['quest']['picture_url']).to be_present
      end
    end
  end
end
