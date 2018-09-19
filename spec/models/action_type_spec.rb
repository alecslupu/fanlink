require "rails_helper"

RSpec.describe ActionType, type: :model do
  describe "#destroy" do
    it "should not let you destroy an action type that has been used in a badge" do
      act_type = create(:action_type)
      p act_type.inspect
      create(:badge, action_type: act_type)
      expect(act_type.destroy).to be_falsey
      expect(act_type).to exist_in_database
      expect(act_type.errors[:base]).not_to be_empty
    end
    it "should not let you destroy an action type that has been used in a badge action" do
      act_type = create(:action_type)
      create(:badge_action, action_type: act_type)
      expect(act_type.destroy).to be_falsey
      expect(act_type).to exist_in_database
      expect(act_type.errors[:base]).not_to be_empty
    end
  end

  describe "#internal_name" do
    it "should allow an internal name with lower case letters numbers and underscores" do
      expect(create(:action_type, internal_name: "abc_d12"))
    end
    it "should not allow an internal name with spaces" do
      at = build(:action_type, internal_name: "abc d12")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with upper case" do
      at = build(:action_type, internal_name: "Abcd12")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with exclamation" do
      at = build(:action_type, internal_name: "abc_d12!")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow a nil internal name" do
      at = build(:action_type, internal_name: nil)
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an empty internal name" do
      at = build(:action_type, internal_name: "")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with less than 3 characters" do
      at = build(:action_type, internal_name: "ab")
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow an internal name with more than 26 characters" do
      at = build(:action_type, internal_name: "a" * 27)
      expect(at).not_to be_valid
      expect(at.errors[:internal_name]).not_to be_empty
    end
    it "should not allow two action types to share internal name" do
      at1 = create(:action_type)
      at2 = build(:action_type, internal_name: at1.internal_name)
      expect(at2).not_to be_valid
      expect(at2.errors[:internal_name]).not_to be_empty
    end
    it "should not allow two action types to share name" do
      at1 = create(:action_type)
      at2 = build(:action_type, internal_name: at1.internal_name)
      expect(at2).not_to be_valid
      expect(at2.errors[:internal_name]).not_to be_empty
    end
  end
  describe "#name" do
    it "should allow a name with spaces" do
      at = build(:action_type, name: "Abc d12")
      expect(at).to be_valid
    end
    it "should allow a name with exclamation" do
      at = build(:action_type, name: "abc_d12!")
      expect(at).to be_valid
    end
    it "should not allow a nil name" do
      at = build(:action_type, name: nil)
      expect(at).not_to be_valid
      expect(at.errors[:name]).not_to be_empty
    end
    it "should not allow an empty name" do
      at = build(:action_type, name: "")
      expect(at).not_to be_valid
    end
    it "should not allow a name with less than 3 characters" do
      at = build(:action_type, name: "ab")
      expect(at).not_to be_valid
      expect(at.errors[:name]).not_to be_empty
    end
    it "should not allow a name with more than 36 characters" do
      at = build(:action_type, name: "a" * 37)
      expect(at).not_to be_valid
      expect(at.errors[:name]).not_to be_empty
    end
    it "should not allow two action types to share name" do
      at1 = create(:action_type)
      at2 = build(:action_type, name: at1.name)
      expect(at2).not_to be_valid
      expect(at2.errors[:name]).not_to be_empty
    end
  end
  describe "#valid?" do
    it "should create a valid action type" do
      expect(create(:action_type)).to be_valid
    end
  end
end
