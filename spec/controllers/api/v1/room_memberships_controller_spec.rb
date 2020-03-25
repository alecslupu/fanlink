require "spec_helper"

RSpec.describe Api::V1::RoomMembershipsController, type: :controller do
  before(:each) do
    logout
  end

  describe "#create" do
    it "should make someone a member if current user owns the room" do
      owner = create(:person)
      ActsAsTenant.with_tenant(owner.product) do
        login_as(owner)
        person2 = create(:person)
        room = create(:room, public: false, status: :active, created_by: owner)

        post :create, params: { room_id: room.id, room_membership: { person_id: person2.id } }
        expect(response).to have_http_status(200)
        lm = RoomMembership.last
        expect(lm.room).to eq(room)
        expect(lm.person).to eq(person2)
      end
    end
    it "should not create membership if already a member" do
      owner = create(:person)
      ActsAsTenant.with_tenant(owner.product) do
        login_as(owner)
        room = create(:room, public: false, status: :active, created_by_id: owner.id)
        new_member = create(:person)
        room.members << new_member
        precount = RoomMembership.count
        post :create, params: { room_id: room.id, room_membership: { person_id: new_member.id.to_s } }
        expect(response).to be_unprocessable
        expect(RoomMembership.count - precount).to eq(0)
      end
    end
    it "should not make someone a member if room is inactive" do
      owner = create(:person)
      ActsAsTenant.with_tenant(owner.product) do
        login_as(owner)
        room = create(:room, created_by: owner)
        person2 = create(:person)

        post :create, params: { room_id: room.id, room_membership: { person_id: person2.id } }
        expect(response).to be_not_found
      end
    end
    it "should not make someone a member if room is public" do
      owner = create(:person)
      ActsAsTenant.with_tenant(owner.product) do
        login_as(owner)
        room = create(:room, created_by: owner, public: true)
        person2 = create(:person)

        post :create, params: { room_id: room.id, room_membership: { person_id: person2.id } }
        expect(response).to be_not_found
      end
    end
  end
end
