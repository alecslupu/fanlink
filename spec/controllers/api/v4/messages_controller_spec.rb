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
  end

  # TODO: auto-generated
  describe "GET list" do
    pending
  end

  # TODO: auto-generated
  describe "GET show" do
  end

  # TODO: auto-generated
  describe "POST create" do
    it "creates a new message in a public room and updates the timestamp" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        body = "Do you like my body?"
        room = create(:room, public: true, status: :active)

        expect(room.last_message_timestamp).to eq(nil)

        timestamp = DateTime.now.to_i
        post :create, params: { room_id: room.id,  message: { body: body } }
        expect(response).to be_successful

        msg = Message.last

        expect(msg.room).to eq(room)
        expect(msg.person).to eq(person)
        expect(msg.body).to eq(body)
        expect(json["message"]["body"]).to eq(body)
        expect(room.reload.last_message_timestamp).to be >= timestamp
      end
    end

    it "should create a new message in a private room and updates the timestamp" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        room = create(:room, created_by: person, status: :active)
        expect(room.last_message_timestamp).to eq(nil)

        room.members << person
        other_member = create(:person, product: person.product)
        room.members << other_member
        login_as(person)
        body = "Do you like my body?"
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
  end

  # TODO: auto-generated
  describe "PUT update" do
    it "does not update the timestamp" do
      admin_person = create(:admin_user)
      ActsAsTenant.with_tenant(admin_person.product) do
        login_as(admin_person)
        room = create(:room, public: true, status: :active, last_message_timestamp: 1)
        msg = create(:message, room: room)

        expect {
          patch :update, params: { id: msg.id, message: { hidden: true } }
        }.not_to change { room.last_message_timestamp }

      end
    end
  end

  # TODO: auto-generated
  describe "GET stats" do
    pending
  end

end
