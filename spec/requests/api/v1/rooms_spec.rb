describe "Rooms (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @room1 = create(:room, public: true, status: :active, product: @product)
    @room2 = create(:room, public: true, status: :active, product: @product)
    @inactive_room = create(:room, public: true, status: :inactive, product: @product)
    @deleted_room = create(:room, public: true, status: :deleted, product: @product)
    @private_room = create(:room, public: false, status: :active, product: @product)
    @private_room.room_memberships.create(person_id: @person.id)
    @private_room2 = create(:room, public: false, status: :active, product: @product)
    @private_room2.room_memberships.create(person_id: @person.id)
    @private_room3 = create(:room, public: false, status: :active, product: @product)
    @other_product_room = create(:room, public: true, status: :active, product: create(:product))
    @public_actives = [@room1, @room2]
    @not_public_actives = [@inactive_room, @deleted_room, @private_room, @other_product_room]
  end

  before(:each) do
    logout
  end

  describe "#index" do
    it "should get a list of active public rooms when private param not specified" do
      login_as(@person)
      get "/rooms"
      expect(response).to be_success
      room_ids = json["rooms"].map { |r| r["id"] }
      expect(room_ids.sort).to eq(@public_actives.map { |pa| pa.id }.sort)
      expect(room_ids & @not_public_actives.map { |npa| npa.id }).to be_empty
    end
    it "should get a list of active public rooms when private param is false" do
      login_as(@person)
      get "/rooms", params: { private: "false" }
      expect(response).to be_success
      room_ids = json["rooms"].map { |r| r["id"] }
      expect(room_ids.sort).to eq(@public_actives.map { |pa| pa.id }.sort)
    end
    it "should get a list of active private rooms of which user is a member when private param is true" do
      login_as(@person)
      get "/rooms", params: { private: "true" }
      expect(response).to be_success
      room_ids = json["rooms"].map { |r| r["id"] }
      expect(room_ids.sort).to eq([@private_room.id, @private_room2.id].sort)
    end
  end

  describe "#create" do
    it "should create a private room with a list of members" do
      login_as(@person)
      member = create(:person, product: @product)
      n = "Some Room"
      post "/rooms", params: { room: { name: n, member_ids: [ member.id.to_s ] } }
      expect(response).to be_success
      room = Room.last
      expect(room.name).to eq(n)
      members = room.members
      expect(members.count).to eq(2)
      expect(members.sort).to eq([member, @person].sort)
    end
  end

end
