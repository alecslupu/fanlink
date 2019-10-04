require "rails_helper"

RSpec.describe Api::V4::RoomsController, type: :controller do
  # TODO: auto-generated
  describe "GET index" do
    pending
  end

  # TODO: auto-generated
  describe "GET show" do
    pending
  end

  # TODO: auto-generated
  describe "POST create" do
    it "should not create a private room if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        member = create(:person)
        n = "Some Room"
        post :create, params: { room: { name: n, member_ids: [ member.id.to_s ] } }
        expect(response).to be_unauthorized
      end
    end
    it "should create a private room with a list of members and make it active" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expect_any_instance_of(Room).to receive(:new_room)
        member = create(:person)
        n = "Some Room"
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
    it "should not include blocked users in private room" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        expect_any_instance_of(Room).to receive(:new_room)
        member = create(:person)
        member_blocked = create(:person)
        person.block(member_blocked)
        expect(person.reload.blocked?(member_blocked)).to be_truthy
        post :create, params: { room: { name: "some roome", member_ids: [ member.id.to_s, member_blocked.id.to_s ] } }
        expect(response).to be_successful
        room = Room.last
        members = room.members
        expect(members.count).to eq(2)
        expect(members).not_to include(member_blocked)
      end
    end

    it "should not create a private room with only blocked users" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        member_blocked = create(:person)
        member_blocked2 = create(:person)
        person.block(member_blocked)
        person.block(member_blocked2)
        expect(person.reload.blocked?(member_blocked)).to be_truthy
        expect(person.reload.blocked?(member_blocked2)).to be_truthy
        post :create, params: { room: { name: "room", member_ids: [member_blocked.id.to_s, member_blocked2.id.to_s] } }
        expect(response).to have_http_status(422)
        expect(json["errors"]).to include("could not save data")
      end
    end
  end

  # TODO: auto-generated
  describe "PUT update" do
    pending
  end
end
