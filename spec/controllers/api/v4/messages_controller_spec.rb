# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V4::MessagesController, type: :controller do
  describe 'GET index' do
    before :each do
      allow_any_instance_of(Room).to receive(:clear_message_counter).and_return(true)
    end
    it 'returns all the messages with the attached audio' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        from = Date.today - 1.day
        to = Date.today
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        msg = create_list(
          :message,
          3,
          room: private_room,
          body: 'this is my body',
          audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4')
        )

        get :index,
            params: {
              room_id: private_room.id,
              from_date: from,
              to_date: to
            }
        expect(response).to be_successful
        expect(json['messages'].size).to eq(3)
        json['messages'].each do |message|
          expect(message['audio_url']).not_to eq(nil)
        end
      end
    end

    it 'should get a list of messages not to include blocked people' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        unblocked = create(:person)
        blocked = create(:person)
        blocked2 = create(:person)
        person.block(blocked)
        person.block(blocked2)
        unblocked_msg = create(:message, person: unblocked, room_id: room.id)
        blocked_msg = create(:message, person: blocked, room_id: room.id)
        blocked_msg2 = create(:message, person: blocked, room_id: room.id)
        get :index, params: { room_id: room.id }
        expect(response).to be_successful
        expect(json['messages'].map { |m| m['id'] }).not_to include(blocked_msg.id)
        expect(json['messages'].map { |m| m['id'] }).not_to include(blocked_msg.id)
        expect(json['messages'].map { |m| m['id'] }).to include(unblocked_msg.id)
      end
    end

    it 'returns all the messages with the attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        from = Date.today - 1.day
        to = Date.today
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        create_list(
          :message,
          3,
          created_at: to,
          room: private_room,
          body: 'this is my body',
          picture: fixture_file_upload('images/better.png', 'image/png')
        )
        get :index,
            params: {
              room_id: private_room.id,
              from_date: from,
              to_date: to
            }
        expect(response).to be_successful
        expect(json['messages'].size).to eq(3)
        json['messages'].each do |message|
          expect(message['picture_url']).not_to eq(nil)
        end
      end
    end

    it "returns all the room's messages after the given one in the correct order" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, status: :active, public: true)
        msg1 = create(:message, room_id: room.id)
        msg2 = create(:message, room_id: room.id, created_at: DateTime.now + 1)
        msg3 = create(:message, room_id: room.id, created_at: msg2.created_at + 1)
        msg4 = create(:message, room_id: room.id, created_at: msg2.created_at + 2)

        get :index,
            params: {
              room_id: room.id,
              message_id: msg2.id,
              chronologically: 'after'
            }

        expect(response).to be_successful
        expect(json['messages'].size).to eq(2)
        expect(json['messages'].map { |m| m['id'] }).to eq([msg3.id, msg4.id])
      end
    end

    it "returns all the room's messages before the given one in the correct order" do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, status: :active, public: true)
        msg1 = create(:message, room_id: room.id)
        msg2 = create(:message, room_id: room.id)
        msg3 = create(:message, room_id: room.id, created_at: DateTime.now + 1)
        msg4 = create(:message, room_id: room.id, created_at: DateTime.now + 2)

        get :index,
            params: {
              room_id: room.id,
              message_id: msg3.id,
              chronologically: 'before'
            }

        expect(response).to be_successful
        expect(json['messages'].size).to eq(2)
        expect(json['messages'].map { |m| m['id'] }).to eq([msg2.id, msg1.id])
      end
    end

    it "returns all the room's pinned messages after the given one in the correct order" do
      person = create(:admin_user, pin_messages_from: true)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, status: :active, public: true)
        msg1 = create(:message, room_id: room.id)
        msg2 = create(:message, room_id: room.id, created_at: DateTime.now + 1)
        msg3 = create(:message, room_id: room.id, created_at: msg2.created_at + 1, person_id: person.id)
        msg4 = create(:message, room_id: room.id, created_at: msg2.created_at + 2, person_id: person.id)
        msg5 = create(:message, room_id: room.id, created_at: msg2.created_at + 3)

        get :index,
            params: {
              room_id: room.id,
              message_id: msg2.id,
              chronologically: 'after',
              pinned: 'yes'
            }

        expect(response).to be_successful
        expect(json['messages'].size).to eq(2)
        expect(json['messages'].map { |m| m['id'] }).to eq([msg3.id, msg4.id])
      end
    end

    it "returns all the room's pinned messages before the given one" do
      person = create(:admin_user, pin_messages_from: true)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, status: :active, public: true)
        msg1 = create(:message, room_id: room.id, person_id: person.id)
        msg2 = create(:message, room_id: room.id, person_id: person.id)
        msg3 = create(:message, room_id: room.id, created_at: DateTime.now + 1)
        msg4 = create(:message, room_id: room.id, created_at: DateTime.now + 2)
        msg5 = create(:message, room_id: room.id)

        get :index,
            params: {
              room_id: room.id,
              message_id: msg3.id,
              chronologically: 'before',
              pinned: 'yes'
            }

        expect(response).to be_successful
        expect(json['messages'].size).to eq(2)
        expect(json['messages'].map { |m| m['id'] }).to eq([msg2.id, msg1.id])
      end
    end

    it 'returns all the messages from the room if only chronologically param is given' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, status: :active, public: true)
        msg1 = create(:message, room_id: room.id)
        msg2 = create(:message, room_id: room.id, created_at: DateTime.now + 2)

        get :index,
            params: {
              room_id: room.id,
              after_message: false
            }

        expect(response).to be_successful
        expect(json['messages'].size).to eq(2)
      end
    end

    it 'returns all the messages from the room if only the message_id is given' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, status: :active, public: true)
        msg1 = create(:message, room_id: room.id)
        msg2 = create(:message, room_id: room.id, created_at: DateTime.now + 2)

        get :index,
            params: {
              room_id: room.id,
              message_id: msg2.id
            }

        expect(response).to be_successful
        expect(json['messages'].size).to eq(2)
      end
    end

    it 'returns all the messages from the room if chronologically params has bad value' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, status: :active, public: true)
        msg1 = create(:message, room_id: room.id)
        msg2 = create(:message, room_id: room.id, created_at: DateTime.now + 2)

        get :index,
            params: {
              room_id: room.id,
              message_id: msg2.id,
              chronologically: 'wrong'
            }

        expect(response).to be_successful
        expect(json['messages'].size).to eq(2)
      end
    end

    it 'gets a list of messages not to include the ones reported by current user' do
      person = create(:person)

      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)

        person2 = create(:person)
        msg = create(:message, room_id: room.id)
        reported_msg = create(:message, room_id: room.id)
        not_user_reported_msg = create(:message, room_id: room.id)
        create(:message_report, message: reported_msg, status: :pending, person_id: person.id)
        create(:message_report, message: not_user_reported_msg, status: :pending, person_id: person2.id)

        get :index, params: { room_id: room.id }

        expect(response).to be_successful
        expect(json['messages'].count).to eq(2)
        expect(json['messages'].map { |m| m['id'] }.sort).to eq([msg.id, not_user_reported_msg.id])
      end
    end
  end

  # TODO: auto-generated
  describe 'POST create' do
    before :each do
      allow_any_instance_of(Message).to receive(:post).and_return(true)
      allow_any_instance_of(Room).to receive(:increment_message_counters).and_return(true)
    end
    it 'creates a new message in a public room updates the timestamp' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = 'Do you like my body?'
        room = create(:room, public: true, status: :active)
        timestamp = DateTime.now.to_i

        post :create, params: { room_id: room.id, message: { body: body } }

        expect(response).to be_successful

        msg = Message.last

        expect(msg.room).to eq(room)
        expect(msg.person).to eq(person)
        expect(msg.body).to eq(body)
        expect(json['message']['body']).to eq(body)
        expect(room.reload.last_message_timestamp).to be >= timestamp
      end
    end

    it 'should create a new message in a private room and updates the timestamp' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, created_by: person, status: :active)
        expect(room.last_message_timestamp).to eq(0)

        room.members << person
        other_member = create(:person, product: person.product)
        room.members << other_member
        login_as(person)
        body = 'Do you like my body?'
        timestamp = DateTime.now.to_i

        post :create, params: { room_id: room.id, message: { body: body } }

        expect(response).to be_successful
        msg = Message.last
        expect(msg.room).to eq(room)
        expect(msg.person).to eq(person)
        expect(msg.body).to eq(body)
        expect(room.reload.last_message_timestamp).to be >= timestamp
      end
    end
    it 'should create a new message with an attached image' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = 'Do you like my body?'
        room = create(:public_active_room,)

        post :create,
             params: {
               room_id: room.id,
               message: {
                 body: body,
                 picture: fixture_file_upload('images/better.png', 'image/png')
               }
             }
        expect(response).to be_successful
        expect(json['message']['picture_url']).not_to eq(nil)
        expect(Message.last.picture.attached?).to be_truthy
      end
    end

    it 'should create a new message with an attached audio' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = 'Do you like my body?'
        room = create(:public_active_room,)
        post :create,
             params: {
               room_id: room.id,
               message: {
                 body: body,
                 audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4')
               }
             }
        expect(response).to be_successful
        expect(json['message']['audio_url']).not_to eq(nil)
        expect(Message.last.audio.attached?).to be_truthy
      end
    end
  end
  describe 'GET show' do
    it 'returns the message with the attached picture' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        msg = create(
          :message,
          room: private_room,
          body: 'this is my body',
          picture: fixture_file_upload('images/better.png', 'image/png')
        )
        get :show, params: { room_id: private_room.id, id: msg.id }

        expect(response).to be_successful
        expect(json['message']['picture_url']).not_to eq(nil)
      end
    end

    it 'returns the message with the attached audio' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        msg = create(
          :message,
          room: private_room,
          body: 'this is my body',
          audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4')
        )
        get :show, params: { room_id: private_room.id, id: msg.id }

        expect(response).to be_successful
        expect(json['message']['audio_url']).not_to eq(nil)
      end
    end

    it ' should not return the message from a blocked person' do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        blocked = create(:person)
        person.block(blocked)
        blocked_msg = create(:message, person: blocked, room_id: room.id)
        get :show, params: { room_id: room.id, id: blocked_msg.id }
        expect(response).to have_http_status(404)
        expect(response.body).to include('Not found')
      end
    end
  end

  # TODO: auto-generated
  describe 'PUT update' do
    it 'does not update the timestamp' do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        login_as(admin_person)
        room = create(:room, public: true, status: :active, last_message_timestamp: 1)
        msg = create(:message, room: room)

        allow_any_instance_of(Message).to receive(:delete_real_time).and_return(true)
        expect {
          patch :update, params: { id: msg.id, message: { hidden: true } }
        }.not_to change { room.last_message_timestamp }
      end
    end
  end

  describe 'list' do
    it 'returns all the messages with the attached audio' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        from = Date.today - 1.day
        to = Date.today
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by

        allow(subject).to receive(:apply_filters).and_return build_list(
          :message,
          3,
          room: private_room,
          body: 'this is my body',
          audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4')
        )

        get :list

        expect(response).to be_successful
        expect(json['messages'].size).to eq(3)
        json['messages'].each do |message|
          expect(message['audio_url']).not_to eq(nil)
        end
      end
    end
    it 'returns all the messages with the attached image' do
      person = create(:admin_user)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        from = Date.today - 1.day
        to = Date.today
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        allow(subject).to receive(:apply_filters).and_return build_list(
          :message,
          3,
          created_at: to,
          room: private_room,
          body: 'this is my body sss',
          picture: fixture_file_upload('images/better.png', 'image/png')
        )

        get :list

        expect(response).to be_successful
        expect(json['messages'].size).to eq(3)
        json['messages'].each do |message|
          expect(message['picture_url']).not_to eq(nil)
        end
      end
    end
  end

  # TODO: auto-generated
  describe 'GET stats' do
    pending
  end
end
