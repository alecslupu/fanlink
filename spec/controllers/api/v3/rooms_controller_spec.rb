# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V3::RoomsController, type: :controller do
  # TODO: auto-generated
  describe 'POST create' do

    it 'shold attach picture to public rooms when provided' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        post :create,
          params: {
            room: {
              name: 'name',
              public: true,
              picture: fixture_file_upload('images/better.png', 'image/png')
            }
          }
        expect(response).to be_successful
        expect(json['room']['picture_url']).not_to eq(nil)
        expect(Room.last.picture).not_to eq(nil)
      end
    end
  end

  # TODO: auto-generated
  describe 'DELETE destroy' do
    pending
  end

  describe 'GET index' do
    it 'should return active public rooms with their attached pictures' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:room, 3, public: true, status: :active, picture: fixture_file_upload('images/better.png', 'image/png'))
        get :index

        expect(response).to be_successful
        expect(json['rooms'].size).to eq(3)
        json['rooms'].each do |room|
          expect(room['picture_url']).not_to eq(nil)
        end
      end
    end
  end

  describe 'PUT update' do
    it "should let an admin update a public room's picture" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        public_room = create(:room, public: true, status: :active)
        put :update, params: { id: public_room.id, room: { picture: fixture_file_upload("images/better.png", "image/png") } }

        expect(response).to be_successful
        expect(json["room"]["picture_url"]).not_to eq(nil)
        expect(Room.find(public_room.id).picture.attached?).to eq(true)
        expect(json["room"]["picture_url"]).not_to be_nil
      end
    end

    it "should update a normal roomowner public room picture" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        public_room = create(:room, public: true, status: :active, created_by: person)
        put :update, params: { id: public_room.id, room: { picture: fixture_file_upload("images/better.png", "image/png") } }

        expect(response).to be_successful
        expect(Room.find(public_room.id).picture.attached?).to eq(false)
        expect(json["room"]["picture_url"]).to eq(nil)
      end
    end
  end
end
