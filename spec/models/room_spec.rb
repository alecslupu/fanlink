RSpec.describe Room, type: :model do

  describe "#destroy" do
    it "should not let you destroy a room that has messages" do
      pending("to do")
      fail
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
      room1 = create(:room, name: "abc", public: true)
      room2 = build(:room, product: room1.product, name: "abc", public: true)
      expect(room2).not_to be_valid
      expect(room2.errors[:name]).not_to be_empty
    end
  end

end
