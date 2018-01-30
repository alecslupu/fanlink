RSpec.describe Level, type: :model do

  describe "#internal_name" do
    it "should allow an internal name with lower case letters numbers and underscores" do
      expect(create(:level, internal_name: "abc_d12"))
    end
    it "should not allow an internal name with spaces" do
      at = build(:level, internal_name: "abc d12")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with upper case" do
      at = build(:level, internal_name: "Abcd12")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with exclamation" do
      at = build(:level, internal_name: "abc_d12!")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow a nil internal name" do
      at = build(:level, internal_name: nil)
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an empty internal name" do
      at = build(:level, internal_name: "")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with less than 3 characters" do
      at = build(:level, internal_name: "ab")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with more than 26 characters" do
      at = build(:level, internal_name: "a" * 27)
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow two levels in the same product to share internal name" do
      at1 = create(:level)
      at2 = build(:level, internal_name: at1.internal_name)
      expect(at2).not_to be_valid
      expect(at2.errors[:internal_name]).not_to be_empty
    end
    it "should allow two levels in different products to share internal name" do
      b1 = create(:level)
      prod_b2 = create(:product)
      b2 = build(:level, product: prod_b2, internal_name: b1.internal_name)
      expect(b2).to be_valid
    end
    it "should not allow two levels in the same product to share name" do
      at1 = create(:level)
      at2 = build(:level, name: at1.name)
      expect(at2).not_to be_valid
      expect(at2.errors[:name]).not_to be_empty
    end
  end
  describe "#name" do
    it "should allow a name with spaces" do
      at = build(:level, name: "Abc d12")
      expect(at).to be_valid
    end
    it "should allow a name with exclamation" do
      at = build(:level, name: "abc_d12!")
      expect(at).to be_valid
    end
    it "should not allow a nil name" do
      at = build(:level, name: nil)
      expect(at).not_to be_valid
      expect(at.errors[:name]).not_to be_empty
    end
    it "should not allow an empty name" do
      at = build(:level, name: "")
      expect(at).not_to be_valid
    end
    it "should not allow a name with less than 3 characters" do
      at = build(:level, name: "ab")
      expect(at).not_to be_valid
      expect(at.errors[:name]).not_to be_empty
    end
    it "should not allow a name with more than 36 characters" do
      at = build(:level, name: "a" * 37)
      expect(at).not_to be_valid
      expect(at.errors[:name]).not_to be_empty
    end
  end
  describe "#product" do
    it "should not let you create a level without a product" do
      at = build(:level, product: nil)
      expect(at).not_to be_valid
      expect(at.errors[:product]).not_to be_empty
    end
  end
  describe "#valid?" do
    it "should be valid" do
      expect(create(:level)).to be_valid
    end
  end
end
