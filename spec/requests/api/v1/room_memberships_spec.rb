describe "RoomMemberships (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @owner = create(:person, product: @product)
    @member1 = create(:person, product: @product)
    @room = create(:room, public: false, status: :active, created_by_id: @owner.id)
    @inactive_room = create(:room, public: false, status: :inactive, created_by_id: @owner.id)
    @deleted_room = create(:room, public: false, status: :deleted, created_by_id: @owner.id)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should make someone a member if current user owns the room" do
      login_as(@owner)
      post "/rooms/#{@room.id}/room_memberships", params: { room_membership: { person_id: @member1.id.to_s } }
      expect(response).to be_success
      lm = RoomMembership.last
      expect(lm.room).to eq(@room)
      expect(lm.person).to eq(@member1)
    end
  end
end
