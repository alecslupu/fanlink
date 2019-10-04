require "rails_helper"

RSpec.describe Api::V4::MessagesController, type: :controller do
  describe "GET index" do
    it "should get a list of messages not to include blocked people" do
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
        expect(json["messages"].map { |m| m["id"] }).not_to include(blocked_msg.id)
        expect(json["messages"].map { |m| m["id"] }).not_to include(blocked_msg.id)
        expect(json["messages"].map { |m| m["id"] }).to include(unblocked_msg.id)
      end
    end
  end

  # TODO: auto-generated
  describe "GET list" do
    pending
  end

  # TODO: auto-generated
  describe "GET show" do
   it" should not return the message from a blocked person" do
    person = create(:person)
    ActsAsTenant.with_tenant(person.product) do
      room = create(:room, public: true, status: :active)
      login_as(person)
      blocked = create(:person)
      person.block(blocked)
      blocked_msg = create(:message, person: blocked, room_id: room.id)
      get :show, params: { room_id: room.id, id: blocked_msg.id }
      expect(response).to have_http_status(404)
      expect(response.body).to include("Not found")
    end
   end
  end

  # TODO: auto-generated
  describe "POST create" do
    pending
  end

  # TODO: auto-generated
  describe "PUT update" do
    pending
  end

  # TODO: auto-generated
  describe "GET stats" do
    pending
  end

end
