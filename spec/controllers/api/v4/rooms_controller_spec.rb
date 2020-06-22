# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V4::RoomsController, type: :controller do
  # TODO: auto-generated
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
          expect(room['picture_url']).to_not eq(nil)
        end
      end
    end

   it 'should get a list of active public rooms in order based on activity' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        room1 = create(:room, public: true, status: :active)
        message_room1 =  msg = create(:message, person: person, room: room1)
        room2 = create(:room, public: true, status: :active)
        message_room1 =  msg = create(:message, person: person, room: room2)
        inactive_room = create(:room, public: true, status: :inactive)
        deleted_room = create(:room, public: true, status: :deleted)
        private_room = create(:room, public: false, status: :active, created_by: @person)
        private_room.room_memberships.create(person_id: person.id)
        # other_product_room = create(:room, public: true, status: :active, product: create(:product))
        get :index, params: { product: person.product }
        expect(response).to be_successful
        room_ids = json['rooms'].map { |r| r['id'] }
        expect(room_ids).to eq([room2.id.to_s, room1.id.to_s])
      end
    end

    it 'should return public rooms with timestamps and order' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:room, 3, public: true, status: :active)

        get :index, params: { private: false }

        expect(response).to be_successful
        json['rooms'].each do |room|
          expect(room).to include('order')
          expect(room).to include('last_message_timestamp')
        end
      end
    end

    it 'should return private rooms with timestamps and order' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:room, 2, public: false, status: :active, created_by_id: person.id)
        Room.last(2).each do |room|
          room.members << person
        end
        get :index, params: { private: true }

        expect(response).to be_successful
        json['rooms'].each do |room|
          expect(room).to include('order')
          expect(room).to include('last_message_timestamp')
        end
      end
    end

    it 'should returns private rooms with their members having the updated info' do
      person = create(:person, pin_messages_from: false)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, public: false, status: :active, created_by_id: person.id)
        room.members << person
        person.update(pin_messages_from: true)
        expect(person.pin_messages_from).to eq(true)

        get :index, params: { private: true }

        expect(response).to be_successful
        expect(json['rooms'].first['members'].first['pin_messages_from']).to eq(true)
      end
    end
  end

  describe 'GET show' do
    it 'should return an active public room with their attached picture' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, public: true, status: :active, picture: fixture_file_upload('images/better.png', 'image/png'))
        get :show, params: { id: room.id }

        expect(response).to be_successful
        expect(json['room']['picture_url'].size).to_not eq(nil)
      end
    end

    it 'should return an public room with the timestamp and order' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, public: true, status: :active)
        get :show, params: { id: room.id }

        expect(response).to be_successful
        expect(json['room']).to include('order')
        expect(json['room']).to include('last_message_timestamp')
      end
    end

    it 'should return a private room with the timestamp and order' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, public: false, status: :active)
        get :show, params: { id: room.id }

        expect(response).to be_successful
        expect(json['room']).to include('order')
        expect(json['room']).to include('last_message_timestamp')
      end
    end
  end

  describe 'POST create' do

    it 'should attach picture to public rooms when provided' do
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

    it 'should not create a private room if not logged in' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        member = create(:person)
        n = 'Some Room'
        post :create, params: { room: { name: n, member_ids: [ member.id.to_s ] } }
        expect(response).to be_unauthorized
      end
    end
    it 'should create a private room with a list of members and make it active' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expect_any_instance_of(Room).to receive(:new_room)
        member = create(:person)
        n = 'Some Room'
        post :create, params: { room: { name: n, member_ids: [ member.id.to_s ] } }
        expect(response).to be_successful
        room = Room.last
        expect(room.name).to eq(n)
        expect(room.active?).to be_truthy
        members = room.members
        expect(members.count).to eq(2)
        expect(members.sort).to eq([member, person].sort)
      end
    end
    it 'should not include blocked users in private room' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expect_any_instance_of(Room).to receive(:new_room)
        member = create(:person)
        member_blocked = create(:person)
        person.block(member_blocked)
        expect(person.reload.blocked?(member_blocked)).to be_truthy
        post :create, params: { room: { name: 'some roome', member_ids: [ member.id.to_s, member_blocked.id.to_s ] } }
        expect(response).to be_successful
        room = Room.last
        members = room.members
        expect(members.count).to eq(2)
        expect(members).not_to include(member_blocked)
      end
    end

    it 'should not create a private room with only blocked users' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        member_blocked = create(:person)
        member_blocked2 = create(:person)
        person.block(member_blocked)
        person.block(member_blocked2)
        expect(person.reload.blocked?(member_blocked)).to be_truthy
        expect(person.reload.blocked?(member_blocked2)).to be_truthy
        post :create, params: { room: { name: 'room', member_ids: [member_blocked.id.to_s, member_blocked2.id.to_s] } }
        expect(response).to have_http_status(422)
        expect(json['errors']).to include('could not save data')
      end
    end

   it 'should not set public room timestamp' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        current_timestamp = DateTime.now.to_i

        post :create,
             params: {
               room: {
                 name: 'name',
                 public: true
               }
             }

        expect(response).to be_successful
        expect(json['room']['last_message_timestamp']).to be >= current_timestamp
        expect(Room.last.picture).not_to eq(nil)
      end
   end


   it 'should set private room timestamp' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        current_timestamp = DateTime.now.to_i
        allow_any_instance_of(Room).to receive(:new_room).and_return(true)

        post :create,
             params: {
               room: {
                 name: 'name',
                 member_ids: [create(:person).id]
               }
             }
        expect(response).to be_successful
        expect(json['room']['last_message_timestamp']).to be >= current_timestamp
      end
    end
  end

  describe 'PUT update' do
    it "should let an admin update a public room's picture" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        public_room = create(:room, public: true, status: :active)
        put :update, params: { id: public_room.id, room: { picture: fixture_file_upload('images/better.png', 'image/png') } }

        expect(response).to be_successful
        expect(json['room']['picture_url']).not_to eq(nil)
        expect(Room.find(public_room.id).picture.attached?).to eq(true)
        expect(json['room']['picture_url']).not_to be_nil
      end
    end

    it "should not let a roomowner update his public room's picture" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        public_room = create(:room, public: true, status: :active, created_by: person)
        put :update, params: { id: public_room.id, room: { picture: fixture_file_upload('images/better.png', 'image/png') } }

        expect(response).to be_successful
        expect(Room.find(public_room.id).picture.attached?).to eq(false)
        expect(json['room']['picture_url']).to eq(nil)
      end
    end
  end
end
