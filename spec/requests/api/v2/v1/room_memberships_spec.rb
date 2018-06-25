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
    it "should not create membership if already a member" do
      login_as(@owner)
      new_member = create(:person, product: @product)
      @room.members << new_member
      precount = RoomMembership.count
      post "/rooms/#{@room.id}/room_memberships", params: { room_membership: { person_id: new_member.id.to_s } }
      expect(response).to be_unprocessable
      expect(RoomMembership.count - precount).to eq(0)
    end
    it "should not make someone a member if room is inactive" do
      login_as(@owner)
      post "/rooms/#{@inactive_room.id}/room_memberships", params: { room_membership: { person_id: @member1.id.to_s } }
      expect(response).to be_not_found
    end
    it "should not make someone a member if room is public" do
      room = create(:room, created_by_id: @owner.id, public: true)
      login_as(@owner)
      post "/rooms/#{room.id}/room_memberships", params: { room_membership: { person_id: @member1.id.to_s } }
      expect(response).to be_not_found
    end
  end
end
