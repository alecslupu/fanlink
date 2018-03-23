require "rails_helper"

RSpec.describe Badge, type: :model do
  describe "#action_requirement" do
    it "should not let you create a badge without an action requirement" do
      badge = build(:badge, action_requirement: nil)
      expect(badge).not_to be_valid
      expect(badge.errors[:action_requirement]).not_to be_empty
    end
    it "should not let you create a badge with an action requirement less than 1" do
      badge = build(:badge, action_requirement: 0)
      expect(badge).not_to be_valid
      expect(badge.errors[:action_requirement]).not_to be_empty
    end
  end
  describe "#destroy" do
    it "should not let you destroy a badge that has been awarded" do
      badge = create(:badge)
      create(:badge_award, badge: badge)
      expect(badge.destroy).to be_falsey
      expect(badge).to exist_in_database
    end
  end

  describe "#internal_name" do
    it "should allow an internal name with lower case letters numbers and underscores" do
      expect(create(:badge, internal_name: "abc_d12"))
    end
    it "should not allow an internal name with spaces" do
      at = build(:badge, internal_name: "abc d12")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with upper case" do
      at = build(:badge, internal_name: "Abcd12")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with exclamation" do
      at = build(:badge, internal_name: "abc_d12!")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow a nil internal name" do
      at = build(:badge, internal_name: nil)
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an empty internal name" do
      at = build(:badge, internal_name: "")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with less than 3 characters" do
      at = build(:badge, internal_name: "ab")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with more than 26 characters" do
      at = build(:badge, internal_name: "a" * 27)
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow two badges in the same product to share internal name" do
      at1 = create(:badge)
      at2 = build(:badge, internal_name: at1.internal_name)
      expect(at2).not_to be_valid
      expect(at2.errors[:internal_name]).not_to be_empty
    end
    it "should allow two badges in different products to share internal name" do
      b1 = create(:badge)
      prod_b2 = create(:product)
      b2 = build(:badge, product: prod_b2, internal_name: b1.internal_name, action_type: create(:action_type))
      expect(b2).to be_valid
    end
  end
  describe "#product" do
    it "should not let you create a badge without a product" do
      at = build(:badge, product: nil)
      expect(at).not_to be_valid
      expect(at.errors[:product]).not_to be_empty
    end
  end
  describe "#valid?" do
    it "should create a valid badge" do
      expect(create(:badge)).to be_valid
    end
  end
end
