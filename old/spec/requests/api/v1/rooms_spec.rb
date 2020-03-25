describe "Rooms (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @room1 = create(:room, public: true, status: :active, product: @product)
    @room2 = create(:room, public: true, status: :active, product: @product)
    @inactive_room = create(:room, public: true, status: :inactive, product: @product)
    @deleted_room = create(:room, public: true, status: :deleted, product: @product)
    @private_room = create(:room, public: false, status: :active, product: @product, created_by: @person)
    @private_room.room_memberships.create(person_id: @person.id)
    @private_room2 = create(:room, public: false, status: :active, product: @product)
    @private_room2.room_memberships.create(person_id: @person.id)
    @private_room3 = create(:room, public: false, status: :active, product: @product)
    @other_product_room = create(:room, public: true, status: :active, product: create(:product))
    @not_public_actives = [@inactive_room, @deleted_room, @private_room, @other_product_room]
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should not create a private room if not logged in" do
      member = create(:person, product: @product)
      n = "Some Room"
      post "/rooms", params: { room: { name: n, member_ids: [ member.id.to_s ] } }
      expect(response).to be_unauthorized
    end
    it "should create a private room with a list of members and make it active" do
      expect_any_instance_of(Room).to receive(:new_room)
      login_as(@person)
      member = create(:person, product: @product)
      n = "Some Room"
      post "/rooms", params: { room: { name: n, member_ids: [ member.id.to_s ] } }
      expect(response).to be_success
      room = Room.last
      expect(room.name).to eq(n)
      expect(room.active?).to be_truthy
      members = room.members
      expect(members.count).to eq(2)
      expect(members.sort).to eq([member, @person].sort)
    end
    it "should not include blocked users in private room" do
      expect_any_instance_of(Room).to receive(:new_room)
      login_as(@person)
      member = create(:person, product: @product)
      member_blocked = create(:person, product: @product)
      @person.block(member_blocked)
      expect(@person.reload.blocked?(member_blocked)).to be_truthy
      post "/rooms", params: { room: { name: "some roome", member_ids: [ member.id.to_s, member_blocked.id.to_s ] } }
      expect(response).to be_success
      room = Room.last
      members = room.members
      expect(members.count).to eq(2)
      expect(members).not_to include(member_blocked)
    end
  end

  describe "#destroy" do
    it "should completely destroy room without messages" do
      login_as(@person)
      room = create(:room, created_by: @person, product: @person.product)
      expect_any_instance_of(Room).not_to receive(:delete_me)
      delete "/rooms/#{room.id}"
      expect(response).to be_success
      expect(room).not_to exist_in_database
    end
    it "should not delete room if not room owner" do
      expect_any_instance_of(Room).to_not receive(:delete_me)
      login_as(create(:person, product: @person.product))
      room = create(:room, created_by: @person, product: @person.product)
      delete "/rooms/#{room.id}"
      expect(response).to be_unauthorized
      expect(room).to exist_in_database
    end
    it "should mark room deleted if it has messages" do
      login_as(@person)
      room = create(:room, created_by: @person, product: @person.product, status: :active)
      expect_any_instance_of(Room).to receive(:delete_me)
      room.messages.create(person: @person, body: "hi")
      delete "/rooms/#{room.id}"
      expect(response).to be_success
      expect(room).to exist_in_database
      expect(room.reload.deleted?).to be_truthy
    end
  end

  describe "#index" do
    it "should get a list of active public rooms when private param not specified" do
      login_as(@person)
      get "/rooms"
      expect(response).to be_success
      room_ids = json["rooms"].map { |r| r["id"] }
      ActsAsTenant.with_tenant(@person.product) do
        expect(room_ids.sort).to eq(Room.publics.active.map { |pa| pa.id }.sort)
      end
    end
    it "should get a list of active public rooms when private param is false" do
      login_as(@person)
      get "/rooms", params: { private: "false" }
      expect(response).to be_success
      room_ids = json["rooms"].map { |r| r["id"] }
      ActsAsTenant.with_tenant(@person.product) do
        expect(room_ids.sort).to eq(Room.publics.active.map { |pa| pa.id }.sort)
      end
    end
    it "should get a list of active private rooms of which user is a member when private param is true" do
      login_as(@person)
      get "/rooms", params: { private: "true" }
      expect(response).to be_success
      room_ids = json["rooms"].map { |r| r["id"] }
      expect(room_ids.sort).to eq([@private_room.id, @private_room2.id].sort)
    end
  end

  describe "#update" do
    it "should let room owner update room name" do
      login_as(@person)
      new_name = "My Awesome Room"
      put "/rooms/#{@private_room.id}", params: { room: { name: new_name } }
      expect(response).to be_success
      expect(json["room"]["name"]).to eq(new_name)
      expect(@private_room.reload.name).to eq(new_name)
    end
    it "should not let room nonowner update room name" do
      person = create(:person, product: @person.product)
      login_as(person)
      old_name = @private_room.reload.name
      new_name = "My Awesome Room Not Renamed"
      put "/rooms/#{@private_room.id}", params: { room: { name: new_name } }
      expect(response).to be_unauthorized
      expect(@private_room.reload.name).to eq(old_name)
    end
  end

end
