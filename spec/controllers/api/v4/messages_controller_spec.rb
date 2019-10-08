require "rails_helper"

RSpec.describe Api::V4::MessagesController, type: :controller do
  describe "GET index" do
    it "should get a list of messages not to include blocked people" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        blocked = create(:person)
        person.block(blocked)
        blocked_msg = create(:message, person: blocked,room: room)
        create(:message, person: blocked,room: room)
        create(:message, person: blocked,room: room)
        create(:message, person: create(:person),room: room)
        get :index, params: { room_id: room.id }
        expect(response).to be_successful
        expect(json["messages"].map { |m| m["id"] }).not_to include(blocked_msg.id)
      end
    end

    it 'returns all the messages with the attached image' do
      person = create(:person, role: :admin)
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
          body: "this is my body",
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

    it "should create a new message with an attached audio" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = "Do you like my body?"
        room = create(:public_active_room, )
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
        expect(Message.last.audio.exists?).to be_truthy
      end
    end
  end

  describe "create" do
    it "should create a new message with an attached image" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = "Do you like my body?"
        room = create(:public_active_room, )
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
        expect(Message.last.picture.exists?).to be_truthy
      end
    end

    it "should create a new message with an attached audio" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = "Do you like my body?"
        room = create(:public_active_room, )
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
        expect(Message.last.audio.exists?).to be_truthy
      end
    end

    it 'returns all the messages with the attached audio' do
      person = create(:person, role: :admin)
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
          body: "this is my body",
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
  end

  describe "show" do
    it 'returns the message with the attached picture' do
      person = create(:person, role: :admin)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        msg = create(
          :message,
          room: private_room,
          body: "this is my body",
          picture: fixture_file_upload('images/better.png', 'image/png')
        )
        get :show, params: { room_id: private_room.id, id: msg.id }

        expect(response).to be_successful
        expect(json['message']['picture_url']).not_to eq(nil)
      end
    end

    it 'returns the message with the attached audio' do
      person = create(:person, role: :admin)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        msg = create(
          :message,
          room: private_room,
          body: "this is my body",
          audio: fixture_file_upload('audio/small_audio.mp4', 'audio/mp4')
        )
        get :show, params: { room_id: private_room.id, id: msg.id }

        expect(response).to be_successful
        expect(json['message']['audio_url']).not_to eq(nil)
      end
    end
  end

  describe "list" do
    it 'returns all the messages with the attached image' do
      person = create(:person, role: :admin)
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
          body: "this is my body",
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

    it 'returns all the messages with the attached audio' do
      person = create(:person, role: :admin)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        from = Date.today - 1.day
        to = Date.today
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        create_list(
          :message,
          3,
          room: private_room,
          body: "this is my body",
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
  end

  # TODO: auto-generated
  describe "GET stats" do
    pending
  end
end
