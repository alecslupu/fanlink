describe "Rooms (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @room1 = create(:room, public: true, status: :active)
    @room2 = create(:room, public: true, status: :active)
    @inactive_room = create(:room, public: true, status: :inactive)
    @deleted_room = create(:room, public: true, status: :deleted)
    @private_room = create(:room, public: false, status: :active)
    @other_product_room = create(:room, public: true, status: :active, product_id: create(:product).id)
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
      expect(room_ids & @not_public_actives.map { |npa| npa.id }).to be_empty
    end
  end
end
