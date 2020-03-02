require "spec_helper"


RSpec.describe Api::V1::MessagesController, type: :controller do
  before(:each) do
    stub_wisper_publisher("MentionPushNotification",
                         :execute, :message_created)
  end
  describe "#create" do
    before :each do
      allow_any_instance_of(Message).to receive(:post).and_return(true)
    end
    it "should create a new message in a public room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        expect_any_instance_of(Message).to receive(:post)
        expect_any_instance_of(Room).not_to receive(:increment_message_counters) # msg counters are only for closers!..er, private rooms
        login_as(person)

        body = "Do you like my body?"
        room = create(:room, public: true, status: :active)
        post :create, params: {room_id: room.id, message: {body: body}}
        expect(response).to be_successful
        msg = Message.last
        expect(msg.room).to eq(room)
        expect(msg.person).to eq(person)
        expect(msg.body).to eq(body)
        # expect(json["message"]).to eq(message_json(msg))
        expect(message_json(json["message"])).to be true
      end
    end
    it "should create a new message in a public room with mentions" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)

        mentioned1 = create(:person)
        mentioned2 = create(:person)
        expect_any_instance_of(Message).to receive(:post)
        expect_any_instance_of(Room).not_to receive(:increment_message_counters)
        login_as(person)
        body = "Do you like my body?"
        post :create, params: {room_id: room.id, message: {body: body,
                                                           mentions: [{person_id: mentioned1.id,
                                                                       location: 11,
                                                                       length: 8,},
                                                                      {person_id: mentioned2.id,
                                                                       location: 14,
                                                                       length: 4,},],},}
        expect(response).to be_successful
        msg = Message.last
        expect(msg.mentions.count).to eq(2)
        expect(msg.mentions.first.location).to eq(11)
        expect(msg.mentions.first.length).to eq(8)
        expect(json["message"]["mentions"].count).to eq(2)
      end
    end
    it "should not create a new message in a public room with a mention without a person_id" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        expect_any_instance_of(Message).not_to receive(:post)
        mentioned2 = create(:person)
        room = create(:room, public: true, status: :active)

        login_as(person)
        body = "Do you like my body?"
        expect {
          post :create, params: {room_id: room.id, message: {body: body,
                                                             mentions: [{location: 4, length: 11},
                                                                        {person_id: mentioned2.id,
                                                                         location: 5, length: 1,},],},}
        }.to change { Message.count }.by(0)
        expect(response).to be_unprocessable
        expect(json["errors"]).not_to be_empty
      end
    end
    it "should create a new message in a private room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        expect_any_instance_of(Message).to receive(:post)
        expect_any_instance_of(Message).to receive(:private_message_push)
        expect_any_instance_of(Room).to receive(:increment_message_counters)
        room = create(:room, created_by: person, status: :active)
        room.members << person
        other_member = create(:person, product: person.product)
        room.members << other_member
        login_as(person)
        body = "Do you like my body?"
        post :create, params: {room_id: room.id, message: {body: body}}
        expect(response).to be_successful
        msg = Message.last
        expect(msg.room).to eq(room)
        expect(msg.person).to eq(person)
        expect(msg.body).to eq(body)
        # expect(json["message"]).to eq(message_json(msg))
        expect(message_json(json["message"])).to be true
      end
    end
    it "should create a new message in a private room with a mention" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        expect_any_instance_of(Message).to receive(:post)
        expect_any_instance_of(Message).to receive(:private_message_push)
        expect_any_instance_of(Room).to receive(:increment_message_counters)
        room = create(:room, created_by: person, status: :active)
        room.members << person
        other_member = create(:person)
        room.members << other_member
        login_as(person)
        mentioned1 = create(:person)
        body = "Do you like my body?"
        post :create, params: {room_id: room.id,
                               message: {body: body, mentions: [{person_id: mentioned1.id,
                                                                 location: 14,
                                                                 length: 4,}],},}
        expect(response).to be_successful
        msg = Message.last
        expect(msg.mentions.count).to eq(1)
        expect(json["message"]["mentions"].count).to eq(1)
      end
    end
    it "should not create a new message in an inactive room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        room.inactive!
        expect_any_instance_of(Message).to_not receive(:post)
        login_as(person)
        body = "Do you like my body?"
        post :create, params: {room_id: room.id, message: {body: body}}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("This room is no longer active.")
        room.active!
      end
    end
    it "should not create a new message in a deleted room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        room.deleted!
        expect_any_instance_of(Message).to_not receive(:post)
        login_as(person)
        body = "Do you like my body?"
        post :create, params: {room_id: room.id, message: {body: body}}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("This room is no longer active.")
        room.active!
      end
    end
    it "should not let banned user create a message in public chat room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        expect_any_instance_of(Message).not_to receive(:post)
        banned = create(:person, chat_banned: true)
        login_as(banned)
        room = create(:room, public: true, status: :active)

        body = "Do you like my body?"
        precount = Message.count
        post :create, params: {room_id: room.id, message: {body: body}}
        expect(response).to be_unprocessable
        expect(Message.count - precount).to eq(0)
        expect(json["errors"]).to include("You are banned from chat.")
      end
    end
    it "should let banned user create a new message in a private room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        expect_any_instance_of(Message).to receive(:post)
        expect_any_instance_of(Room).to receive(:increment_message_counters)
        room = create(:room, created_by: person, status: :active)
        room.members << person
        other_member = create(:person, chat_banned: true)
        room.members << other_member
        login_as(other_member)
        body = "Do you like my body?"
        expect {
          post :create, params: {room_id: room.id, message: {body: body}}
        }.to change { Message.count }.by(1)
        expect(response).to be_successful
      end
    end

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
  end

  describe "#destroy" do
    it "should hide message from original creator" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        expect_any_instance_of(Message).to receive(:delete_real_time)
        login_as(person)
        msg = create(:message, person: person, room: private_room, body: "this is my body")
        delete :destroy, params: {room_id: private_room.id, id: msg.id}
        expect(response).to be_successful
        expect(msg.reload.hidden).to be_truthy
      end
    end
    it "should hide message by admin" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        expect_any_instance_of(Message).to receive(:delete_real_time)
        login_as(person)
        msg = create(:message, person: person, room: private_room, body: "this is my body")
        delete :destroy, params: {room_id: private_room.id, id: msg.id}
        expect(response).to be_successful
        expect(msg.reload.hidden).to be_truthy
      end
    end
    it "should not hide message from someone else" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, public: true, status: :active)
        expect_any_instance_of(Message).to_not receive(:delete_real_time)
        p = create(:person)
        msg = create(:message, person: p, room: room, body: "this is my body")
        delete :destroy, params: {room_id: room.id, id: msg.id}
        expect(response).to be_unauthorized
        expect(msg.reload.hidden).to be_falsey
      end
    end
    it "should not hide message if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        expect_any_instance_of(Message).to_not receive(:delete_real_time)
        msg = create(:message, person: person, room: room, body: "this is my body")
        delete :destroy, params: {room_id: room.id, id: msg.id}
        expect(response).to be_unauthorized
        expect(msg.reload.hidden).to be_falsey
      end
    end
  end

  describe "#index" do
    before :each do
      allow_any_instance_of(Room).to receive(:clear_message_counter).and_return(true)
    end
    let(:from) { "2018-01-01" }
    let(:to) { "2018-01-03" }
    it "should get a list of messages for a date range without limit" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, public: true, status: :active)
        msg1 = create(:message, room: room, created_at: Date.today - 1.day)
        msg2 = create(:message, room: room)
        expect(Message).to receive(:for_date_range).with(room, Date.parse(from), Date.parse(to), nil).and_return(Message.order(created_at: :desc).where(id: [msg1.id, msg2.id]))
        expect_any_instance_of(Room).to_not receive(:increment_message_counters) # only for priv rooms
        get :index, params: {room_id: room.id, from_date: from, to_date: to}
        expect(response).to be_successful
        expect(json["messages"].map { |m| m["id"] }).to eq([msg2.id.to_s, msg1.id.to_s])
      end
    end
    it "should get a list of messages for a date range with limit" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, public: true, status: :active)
        msg2 = create(:message, room: room)

        expect(Message).to receive(:for_date_range).with(room, Date.parse(from), Date.parse(to), 1).and_return(Message.order(created_at: :desc).where(id: [msg2.id]))
        get :index, params: {room_id: room.id, from_date: from, to_date: to, limit: 1}
        expect(response).to be_successful
        expect(json["messages"].map { |m| m["id"] }).to eq([msg2.id.to_s])
      end
    end
    it "should get a list of messages not to include blocked people" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        blocked = create(:person)
        person.block(blocked)
        blocked_msg = create(:message, person: blocked)
        get :index, params: {room_id: room.id, from_date: from, to_date: "2019-12-01"}
        expect(response).to be_successful
        expect(json["messages"].map { |m| m["id"] }).not_to include(blocked_msg.id)
      end
    end
    it "should return unprocessable if invalid from date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        expect(Message).to_not receive(:for_date_range)
        get :index, params: {room_id: room.id, from_date: "hahahaha", to_date: to, limit: 1}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Missing or invalid date(s)")
      end
    end
    it "should return unprocessable if invalid to date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        expect(Message).to_not receive(:for_date_range)
        get :index, params: {room_id: room.id, from_date: from, to_date: "who me?", limit: 1}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Missing or invalid date(s)")
      end
    end
    it "should return unprocessable if missing from date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        expect(Message).to_not receive(:for_date_range)
        get :index, params: {room_id: room.id, to_date: to, limit: 1}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Missing or invalid date(s)")
      end
    end
    it "should return unprocessable if missing to date" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        expect(Message).to_not receive(:for_date_range)
        get :index, params: {room_id: room.id, from_date: from, limit: 1}
        expect(response).to be_unprocessable
        expect(json["errors"]).to include("Missing or invalid date(s)")
      end
    end
    it "should return 404 if room from another product" do
      room_other = create(:room, product: create(:product))
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expect(Message).to_not receive(:for_date_range)
        get :index, params: {room_id: room_other.id, from_date: from, to_date: to, limit: 1}
        expect(response).to be_not_found
      end
    end
    it "should return not found if room inactive" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        room.inactive!
        expect(Message).to_not receive(:for_date_range)
        get :index, params: {room_id: room.id, from_date: from, to_date: to, limit: 1}
        expect(response).to be_not_found
        room.active!
      end
    end
    it "should return not found if room deleted" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        login_as(person)
        room.deleted!
        expect(Message).to_not receive(:for_date_range)
        get :index, params: {room_id: room.id, from_date: from, to_date: to, limit: 1}
        expect(response).to be_not_found
        room.active!
      end
    end
    it "should return unauthorized if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, public: true, status: :active)
        expect(Message).to_not receive(:for_date_range)
        get :index, params: {room_id: room.id, from_date: from, to_date: to, limit: 1}
        expect(response).to be_unauthorized
      end
    end
    describe "#private?" do
      it "should get messages if member of private room" do
        person = create(:person)
        ActsAsTenant.with_tenant(person.product) do
          private_room = create(:room, public: false, status: :active)
          private_room.members << person << private_room.created_by
          login_as(person)
          msg = create(:message, room: private_room, body: "wat wat")
          expect(Message).to receive(:for_date_range).with(private_room, Date.parse(from), Date.parse(to), 1).and_return(Message.order(created_at: :desc).where(id: [msg.id]))
          expect_any_instance_of(Room).to receive(:clear_message_counter).with(private_room.room_memberships.where(person: person).first)
          get :index, params: {room_id: private_room.id, from_date: from, to_date: to, limit: 1}
          expect(response).to be_successful
          # expect(json["messages"].first).to eq(message_json(msg))
          expect(message_json(json["messages"].first)).to be true
        end
      end
      it "should return not found if not member of private room" do
        person = create(:person)
        ActsAsTenant.with_tenant(person.product) do
          private_room = create(:room, public: false, status: :active)
          private_room.members << person << private_room.created_by
          p = create(:person)
          login_as(p)
          get :index, params: {room_id: private_room.id, from_date: from, to_date: to, limit: 1}
          expect(response).to be_not_found
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
          msg = create_list(
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

      it 'returns all the messages with the attached audio' do
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
            room: private_room,
            body: "this is my body",
            audio: fixture_file_upload('audio/small_audio.mp4', 'video/mp4')
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
  end

  describe "#list" do
    #   let(:product) { create(:product, name: "Test Product 321", internal_name: "test_product_321") }
    #
    #   let!(:membership2) { create(:room_membership, room: room2) }
    #   let!(:admin) { create(:admin_user, product: product) }
    it "should give you all messages from all rooms with no page specified" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        membership1 = create(:room_membership, room: room2, person: create(:person, username: "membership1"))
        msg1 = build(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        msg2 = build(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2")
        msg12 = build(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12")
        msg13 = build(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13")
        msg14 = build(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14")
        msg3 = build(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3")

        login_as(admin_person)
        toget = [msg1, msg2, msg12, msg13, msg14, msg3]

        allow(subject).to receive(:apply_filters).and_return toget
        get :list
        expect(response).to be_successful
        expect(json["messages"].count).to eq(toget.size)
      end
    end
    it "should give you page 1 with 2 per page" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        membership1 = create(:room_membership, room: room2, person: create(:person, username: "membership1"))
        msg1 = create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        msg2 = create(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2")
        msg12 = create(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12")
        msg13 = create(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13")
        msg14 = create(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14")
        msg3 = create(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3")

        toget = [msg3, msg14]
        login_as(admin_person)
        get :list, params: {page: 1, per_page: 2}
        expect(response).to be_successful
        expect(json["messages"].count).to eq(toget.size)
        # expect(json["messages"].first).to eq(message_list_json(toget.first))
        # expect(json["messages"].last).to eq(message_list_json(toget.last))
        expect(message_list_json(json["messages"].first)).to be true
        expect(message_list_json(json["messages"].last)).to be true
      end
    end
    it "should give you page 1 with 2 per page if no page specified" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        membership1 = create(:room_membership, room: room2, person: create(:person, username: "membership1"))
        msg1 = create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        msg2 = create(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2")
        msg12 = create(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12")
        msg13 = create(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13")
        msg14 = create(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14")
        msg3 = create(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3")
        login_as(admin_person)

        toget = [msg3, msg14]
        get :list, params: {per_page: 2}
        expect(response).to be_successful
        expect(json["messages"].count).to eq(toget.size)
        # expect(json["messages"].first).to eq(message_list_json(toget.first))
        # expect(json["messages"].last).to eq(message_list_json(toget.last))
        expect(message_list_json(json["messages"].first)).to be true
        expect(message_list_json(json["messages"].last)).to be true
      end
    end
    it "should give you page 2 with 2 per page" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        membership1 = create(:room_membership, room: room2, person: create(:person, username: "membership1"))
        msg1 = create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        msg2 = create(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2")
        msg12 = create(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12")
        msg13 = create(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13")
        msg14 = create(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14")
        msg3 = create(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3")
        login_as(admin_person)

        toget = [msg13, msg12]
        get :list, params: {page: 2, per_page: 2}
        expect(response).to be_successful
        expect(json["messages"].count).to eq(toget.size)
        # expect(json["messages"].first).to eq(message_list_json(toget.first))
        # expect(json["messages"].last).to eq(message_list_json(toget.last))
        expect(message_list_json(json["messages"].first)).to be true
        expect(message_list_json(json["messages"].last)).to be true
      end
    end
    it "should give you messages filtered on id" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        membership1 = create(:room_membership, room: room2, person: create(:person, username: "membership1"))
        msg1 = create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        msg2 = create(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2")
        msg12 = create(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12")
        msg13 = create(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13")
        msg14 = create(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14")
        msg3 = create(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3")
        login_as(admin_person)

        get :list, params: {id_filter: msg1.id}
        expect(response).to be_successful
        expect(json["messages"].count).to eq(1)
        # expect(json["messages"].first).to eq(message_list_json(msg1))
        expect(message_list_json(json["messages"].first)).to be true
      end
    end
    it "should give you messages filtered on person" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        membership1 = create(:room_membership, room: room2, person: create(:person, username: "membership1"))
        msg1 = create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        msg2 = create(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2")
        msg12 = create(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12")
        msg13 = create(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13")
        msg14 = create(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14")
        msg3 = create(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3")
        login_as(admin_person)

        get :list, params: {person_filter: "ship1"}
        expect(response).to be_successful
        expect(json["messages"].count).to eq(1)
        # expect(json["messages"].first).to eq(message_list_json(msg3))
        expect(message_list_json(json["messages"].first)).to be true
      end
    end
    it "should give you messages filtered on room" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        membership1 = create(:room_membership, room: room2, person: create(:person, username: "membership1"))
        msg1 = create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        msg2 = create(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2")
        msg12 = create(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12")
        msg13 = create(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13")
        msg14 = create(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14")
        msg3 = create(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3")
        login_as(admin_person)

        toget = [msg14, msg13, msg12, msg2, msg1]
        get :list, params: {room_id_filter: room1.id}
        expect(response).to be_successful
        expect(json["messages"].count).to eq(toget.size)
        # expect(json["messages"].last).to eq(message_list_json(toget.last))
        # expect(json["messages"].first).to eq(message_list_json(toget.first))
        expect(message_list_json(json["messages"].last)).to be true
        expect(message_list_json(json["messages"].first)).to be true
      end
    end
    it "should give you messages filtered on body" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        membership1 = create(:room_membership, room: room2, person: create(:person, username: "membership1"))
        msg1 = create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        msg2 = create(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2")
        msg12 = create(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12")
        msg13 = create(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13")
        msg14 = create(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14")
        msg3 = create(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3")
        login_as(admin_person)
        get :list, params: {body_filter: "his is msg1"}
        expect(response).to be_successful
        expect(json["messages"].count).to eq(1)
        # expect(json["messages"].first).to eq(message_list_json(msg1))
        expect(message_list_json(json["messages"].first)).to be true
      end
    end
    it "should give you reported messages" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        msg1 = create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        login_as(admin_person)
        create(:message_report, message: msg1)
        get :list, params: {reported_filter: "Yes"}
        expect(response).to be_successful
        expect(json["messages"].count).to eq(1)
        # expect(json["messages"].first).to eq(message_list_json(msg1))
        expect(message_list_json(json["messages"].first)).to be true
      end
    end
    it "should return unauth if not logged in" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        get :list
        expect(response).to be_unauthorized
      end
    end
    it "should return unauth if not admin" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        get :list
        expect(response).to be_unauthorized
      end
    end
    it "should give you messages filtered on room and person" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        room1 = create(:room, public: true)
        room2 = create(:room, public: false)
        membership1 = create(:room_membership, room: room2, person: create(:person, username: "membership1"))
        msg1 = create(:message, created_at: Time.now - 10.minutes, room: room1, body: "this is msg1", person: create(:person, username: "message1person"))
        msg2 = create(:message, created_at: Time.now - 9.minutes, room: room1, body: "msg2")
        msg12 = create(:message, created_at: Time.now - 8.minutes, room: room1, body: "msg12")
        msg13 = create(:message, created_at: Time.now - 7.minutes, room: room1, body: "msg13")
        msg14 = create(:message, created_at: Time.now - 6.minutes, room: room1, body: "msg14")
        msg3 = create(:message, created_at: Time.now - 5.minutes, room: room2, person: membership1.person, body: "msg3")
        login_as(admin_person)
        get :list, params: {room_id_filter: room1.id, person_filter: "essage1"}
        expect(response).to be_successful
        expect(json["messages"].count).to eq(1)
        # expect(json["messages"].first).to eq(message_list_json(msg1))
        expect(message_list_json(json["messages"].first)).to be true
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
        toget = build_list(
          :message,
          3,
          created_at: to,
          room: private_room,
          body: "this is my body",
          picture: fixture_file_upload('images/better.png', 'image/png')
        )

        allow(subject).to receive(:apply_filters).and_return toget

        get :list

        expect(response).to be_successful
        expect(json['messages'].size).to eq(3)
        json['messages'].each do |message|
          expect(message['picture_url']).not_to eq(nil)
        end
      end
    end
  end

  describe "#show" do
    it "should get a single private message" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        msg = create(:message, room: private_room, body: "this is my body")
        get :show, params: {room_id: private_room.id, id: msg.id}
        expect(response).to be_successful
        # expect(json["message"]).to eq(message_json(msg))
        expect(message_json(json["message"])).to be true
      end
    end
    it "should not get a single private message from a blocked user" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        blocked = create(:person)
        person.block(blocked)
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << blocked
        msg = create(:message, room: private_room, body: "this is my body", person: blocked)
        get :show, params: {room_id: private_room.id, id: msg.id}
        expect(response).to be_not_found
      end
    end
    it "should not get message if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        msg = create(:message, room: private_room, body: "this is my body")
        get :show, params: {room_id: private_room.id, id: msg.id}
        expect(response).to be_unauthorized
      end
    end
    it "should not get message if not a member of the room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(create(:person))
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        msg = create(:message, room: private_room, body: "this is my body")
        get :show, params: {room_id: private_room.id, id: msg.id}
        expect(response).to be_not_found
      end
    end
    it "should not get message if message hidden" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        private_room = create(:room, public: false, status: :active)
        private_room.members << person << private_room.created_by
        msg = create(:message, room: private_room, body: "this is my body", hidden: true)
        get :show, params: {room_id: private_room.id, id: msg.id}
        expect(response).to be_not_found
      end
    end
    it "should not get message from public room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, public: true, status: :active)
        msg = create(:message, room: room, body: "this is my body")
        get :show, params: {room_id: room.id, id: msg.id}
        expect(response).to be_not_found
      end
    end

    it 'returns the message with the attached picture' do
      person = create(:admin_user)
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
      person = create(:admin_user)
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

  describe "#update" do
    it "should hide a message by an admin" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        login_as(admin_person)
        expect_any_instance_of(Message).to receive(:delete_real_time)
        msg = create(:message)
        expect(msg.hidden).to be_falsey
        patch :update, params: {id: msg.id, message: {hidden: true}}
        expect(response).to be_successful
        expect(msg.reload.hidden).to be_truthy
        # expect(json["message"]).to eq(message_list_json(msg))
        expect(message_list_json(json["message"])).to be true
      end
    end
    it "should unhide a message by an admin" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        login_as(admin_person)
        expect_any_instance_of(Message).to_not receive(:delete_real_time)
        msg = create(:message, hidden: true)
        expect(msg.hidden).to be_truthy
        patch :update, params: {id: msg.id, message: {hidden: false}}
        expect(response).to be_successful
        expect(msg.reload.hidden).to be_falsey
        # expect(json["message"]).to eq(message_list_json(msg))
        expect(message_list_json(json["message"])).to be true
      end
    end
    it "should not hide a message if not logged in" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        expect_any_instance_of(Message).to_not receive(:delete_real_time)
        msg = create(:message, room: create(:room, public: true))
        patch :update, params: {id: msg.id, message: {hidden: true}}
        expect(response).to be_unauthorized
        expect(msg.reload.hidden).to be_falsey
      end
    end
  end
end
