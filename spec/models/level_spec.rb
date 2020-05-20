# frozen_string_literal: true
RSpec.describe Level, type: :model do
  context "Valid" do
    it { expect(build(:level)).to be_valid }
  end
  describe "#internal_name" do
    it "should allow an internal name with lower case letters numbers and underscores" do
      expect(build(:level, internal_name: "abc_d12"))
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
      ActsAsTenant.with_tenant(prod_b2) do
        b2 = build(:level, internal_name: b1.internal_name)
        expect(b2.product).to eq(prod_b2)
        expect(b2).to be_valid
      end
    end
  end
  describe "#name" do

    it "returns the untranslated version" do
      expect(build(:level, name: { "un" => "something untranslated" }).name).to eq("something untranslated")
    end
    it "returns the translated version" do
      expect(build(:level, name: { "un" => "something untranslated", "en" => "something in english" }).name).to eq("something in english")
    end

    it "should allow a name with spaces" do
      expect(build(:level, name: "Abc d12")).to be_valid
    end
    it "should allow a name with exclamation" do
      expect(build(:level, name: "abc_d12!")).to be_valid
    end
  end
  describe "#points" do
    it "should not let you create a level without a point value" do
      level = build(:level, points: nil)
      expect(level).not_to be_valid
      expect(level.errors[:points]).not_to be_empty
    end
    it "should not let you create a level with a point requirement less than 1" do
      level = build(:level, points: 0)
      expect(level).not_to be_valid
      expect(level.errors[:points]).not_to be_empty
    end
    it "should not let levels share point values within a product" do
      ActsAsTenant.with_tenant(create(:product)) do
        level = create(:level)
        l2 = build(:level, points: level.points)
        expect(l2).not_to be_valid
        expect(l2.errors[:points]).not_to be_empty
      end
    end
    it "should let levels share point values in different products" do
      l1 = create(:level, points: 10)
      ActsAsTenant.with_tenant(create(:product)) do
        expect(build(:level, points: l1.points)).to be_valid
      end
    end
  end
end
