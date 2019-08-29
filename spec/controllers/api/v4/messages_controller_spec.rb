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
