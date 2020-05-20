# frozen_string_literal: true
require "spec_helper"

RSpec.describe Api::V1::RoomsController, type: :controller do
  describe "#create" do
    it "should not create a private room if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        member = create(:person)
        n = "Some Room"
        post :create, params: { room: { name: n, member_ids: [member.id.to_s] } }
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
        post :create, params: { room: { name: n, member_ids: [member.id.to_s] } }
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
        post :create, params: { room: { name: "some roome", member_ids: [member.id.to_s, member_blocked.id.to_s] } }
        expect(response).to be_successful
        room = Room.last
        members = room.members
        expect(members.count).to eq(2)
        expect(members).not_to include(member_blocked)
      end
    end
  end

  describe "#destroy" do
    it "should completely destroy room without messages" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        room = create(:room, created_by: person)
        expect_any_instance_of(Room).not_to receive(:delete_me)
        delete :destroy, params: { id: room.id }
        expect(response).to be_successful
        expect(room).not_to exist_in_database
      end
    end
    it "should not delete room if not room owner" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        expect_any_instance_of(Room).to_not receive(:delete_me)
        login_as(create(:person))
        room = create(:room, created_by: person)
        delete :destroy, params: { id: room.id }
        expect(response).to be_unauthorized
        expect(room).to exist_in_database
      end
    end
    it "should mark room deleted if it has messages" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        room = create(:room, created_by: person, status: :active)
        expect_any_instance_of(Room).to receive(:delete_me)
        room.messages.create(person: person, body: "hi")
        delete :destroy, params: { id: room.id }
        expect(response).to be_successful
        expect(room).to exist_in_database
        expect(room.reload.deleted?).to be_truthy
      end
    end
  end

  describe "#index" do
    it "should get a list of active public rooms when private param not specified" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        room1 = create(:room, public: true, status: :active)
        room2 = create(:room, public: true, status: :active)
        inactive_room = create(:room, public: true, status: :inactive)
        deleted_room = create(:room, public: true, status: :deleted)
        private_room = create(:room, public: false, status: :active, created_by: @person)
        private_room.room_memberships.create(person_id: person.id)
        private_room2 = create(:room, public: false, status: :active)
        private_room2.room_memberships.create(person_id: person.id)
        private_room3 = create(:room, public: false, status: :active)
        other_product_room = create(:room, public: true, status: :active, product: create(:product))

        get :index
        expect(response).to be_successful
        room_ids = json["rooms"].map { |r| r["id"] }
        expect(room_ids.sort).to eq(Room.publics.active.map { |pa| pa.id }.sort)
      end
    end
    it "should get a list of active public rooms when private param is false" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)

        room1 = create(:room, public: true, status: :active)
        room2 = create(:room, public: true, status: :active)
        inactive_room = create(:room, public: true, status: :inactive)
        deleted_room = create(:room, public: true, status: :deleted)
        private_room = create(:room, public: false, status: :active, created_by: @person)
        private_room.room_memberships.create(person_id: person.id)
        private_room2 = create(:room, public: false, status: :active)
        private_room2.room_memberships.create(person_id: person.id)
        private_room3 = create(:room, public: false, status: :active)
        other_product_room = create(:room, public: true, status: :active, product: create(:product))

        get :index, params: { private: "false" }
        expect(response).to be_successful
        room_ids = json["rooms"].map { |r| r["id"] }
        expect(room_ids.sort).to eq(Room.publics.active.map { |pa| pa.id }.sort)
      end
    end
    it "should get a list of active private rooms of which user is a member when private param is true" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        private_room = create(:room, public: false, status: :active, created_by: person)
        private_room.room_memberships.create(person_id: person.id)
        private_room2 = create(:room, public: false, status: :active)
        private_room2.room_memberships.create(person_id: person.id)
        get :index, params: { private: "true" }
        expect(response).to be_successful
        room_ids = json["rooms"].map { |r| r["id"] }
        expect(room_ids.sort).to eq([private_room.id, private_room2.id].sort)
      end
    end
    it "should return active public rooms with their attached pictures" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        create_list(:room, 3, public: true, status: :active, picture: fixture_file_upload("images/better.png", "image/png"))
        get :index

        expect(response).to be_successful
        expect(json["rooms"].size).to eq(3)
        json["rooms"].each do |room|
          expect(room["picture_url"]).to_not eq(nil)
        end
      end
    end
  end

  describe "#update" do
    it "should let room owner update room name" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        private_room = create(:room, public: false, status: :active, created_by: person)
        new_name = "My Awesome Room"
        put :update, params: { id: private_room.id, room: { name: new_name } }
        expect(response).to be_successful
        expect(json["room"]["name"]).to eq(new_name)
        expect(private_room.reload.name).to eq(new_name)
      end
    end
    it "should not let room nonowner update room name" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(create(:person))
        private_room = create(:room, public: false, status: :active, created_by: person)
        old_name = private_room.reload.name
        new_name = "My Awesome Room Not Renamed"
        put :update, params: { id: private_room.id, room: { name: new_name } }
        expect(response).to be_unauthorized
        expect(private_room.reload.name).to eq(old_name)
      end
    end
  end
end
