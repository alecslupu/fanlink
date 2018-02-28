RSpec.describe Room, type: :model do

  before(:all) do
    @name = "abc"
    @room = create(:room, name: @name, public: true)
    ActsAsTenant.current_tenant = @room.product
  end

  describe "#destroy" do
    it "should not let you destroy a room that has messages" do
      create(:message, room: @room)
      @room.destroy
      expect(@room).to exist_in_database
    end
  end

  describe "#is_member" do
    let(:member) { create(:person) }
    let(:non_member) { create(:person) }
    let(:room) { create(:room, public: false) }
    it "should return true for room member" do
      room.members << member
      expect(room.is_member?(member)).to be_truthy
    end
    it "should return false for non room member" do
      expect(room.is_member?(non_member)).to be_falsey
    end
  end

  describe "#name" do
    it "should accept a good name format" do
      room = build(:room, name: "My Room")
      expect(room).to be_valid
    end
    it "should not accept a format that is shorter than 3 characters" do
      room = build(:room, name: "aa")
      expect(room).not_to be_valid
      expect(room.errors[:name]).not_to be_blank
    end
    it "should not accept a format that is longer than 36 characters" do
      room = build(:room, name: "a" * 37)
      expect(room).not_to be_valid
      expect(room.errors[:name]).not_to be_blank
    end
    it "should require unique name amongst publics" do
      room2 = build(:room, name: @room.name, public: true)
      expect(room2).not_to be_valid
      expect(room2.errors[:name]).not_to be_empty
    end
    it "should allow shared name for public and private" do
      room2 = build(:room, name: @room.name, public: false)
      expect(room2).to be_valid
    end
    it "should allow shared name for private and private when not created by same person" do
      room1 = create(:room, name: "abc", public: false)
      room2 = build(:room, product: room1.product, name: "abc", public: false, created_by_id: create(:person).id)
      expect(room2).to be_valid
    end
    it "should not allow shared name for private and private when created by same person" do
      room1 = create(:room, name: "abc", public: false, status: :active)
      room2 = build(:room, product: room1.product, name: "abc", public: false, status: :active, created_by_id: room1.created_by_id)
      expect(room2).not_to be_valid
      expect(room2.errors[:name]).not_to be_blank
    end
    it "should allow shared name across products" do
      ActsAsTenant.current_tenant = create(:product)
      room2 = build(:room, name: @room.name, public: true)
      expect(room2).to be_valid
      ActsAsTenant.current_tenant = @room.product
    end
    it "should not require name for private room" do
      room = build(:room, name: nil, public: false)
      expect(room).to be_valid
    end
    it "should require name for public room" do
      room = build(:room, name: nil, public: true)
      expect(room).not_to be_valid
      expect(room.errors[:name]).not_to be_empty
    end
    it "should not allow empty string name for public room" do
      room = build(:room, name: "", public: true)
      expect(room).not_to be_valid
      expect(room.errors[:name]).not_to be_empty
    end
  end

  describe "#picture" do
    it "should not let you have a picture on a private room" do
      room = build(:room, public: false, picture_file_name: "foo.jpg")
      expect(room).not_to be_valid
      expect(room.errors[:picture]).not_to be_empty
    end
  end

end
