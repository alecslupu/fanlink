RSpec.describe RoomMembership, type: :model do
  before(:all) do
    ActsAsTenant.current_tenant = Product.first
    @owner = create(:person)
    @room = create(:room, created_by: @owner)
    @room.room_memberships.create(person_id: @owner.id)
  end

  describe "#person_id" do
    it "should not allow multiple memberships in room for the same person" do
      mem = @room.room_memberships.build(person: @owner)
      expect(mem).not_to be_valid
      expect(mem.errors[:person_id]).not_to be_blank
    end
    it "should not allow room creator membership to be deleted" do
      mem = @room.room_memberships.find_by(person_id: @owner)
      expect {
        mem.destroy
      }.to change { @room.members.count }.by(0)
    end
  end
  describe "#room_id" do
    it "should not allow membership to public room" do
      public_room = create(:room, public: true)
      mem = public_room.room_memberships.create(person_id: create(:person).id)
      expect(mem).not_to be_valid
      expect(mem.errors[:room_id]).not_to be_empty
    end
  end
end
