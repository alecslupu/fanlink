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
    it "should not require name for private room" do
      room = build(:room, name: nil, public: false)
      expect(room).to be_valid
    end
    it "should not require name for public room" do
      room = build(:room, name: nil, public: true)
      expect(room).to be_valid
    end
    it "should require name for private room" do
      room = build(:room, name: nil, public: true)
      expect(room).to be_valid
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
