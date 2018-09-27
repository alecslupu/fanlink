RSpec.describe ActionType, type: :model do
  context "Validation" do
    subject { create(:action_type) }
    describe "#presence" do
      it do
        should validate_presence_of(:internal_name).with_message(_("Internal name is required."))
        should validate_presence_of(:name).with_message(_("Name is required."))
      end
    end
    describe "#length" do
      it do
        should validate_length_of(:internal_name).is_at_least(3).is_at_most(26).with_message(_("Internal name must be between 3 and 26 characters."))
        should validate_length_of(:name).is_at_least(3).is_at_most(36).with_message(_("Name must be between 3 and 36 characters."))
      end
    end
    describe "#uniqueness" do
      it "should check for uniqueness of name and internal_name" do
        should validate_uniqueness_of(:internal_name).with_message(_("There is already an action type with that internal name."))
        should validate_uniqueness_of(:name).with_message(_("There is already an action type with that name."))
      end
    end
    describe "#format" do
      it "should allow value for internal_name" do
        should allow_value("abc_d12").for(:internal_name)
      end
      it "should allow value for name" do
        should allow_value("Abc d12").for(:name)
        should allow_value("abc_d12!").for(:name)
      end
      it "should not allow value for internal_name" do
        should_not allow_value("abc d12").for(:internal_name)
        should_not allow_value("Abcd12").for(:internal_name)
        should_not allow_value("abc_d12!").for(:internal_name)
        should_not allow_value(nil).for(:internal_name)
      end
      it "should not allow value for name" do
        should_not allow_value(nil).for(:name)
        should_not allow_value("").for(:name)
      end
    end
  end
  context "Methods" do
    describe "#destroy" do
      it "should not let you destroy an action type that has been used in a badge" do
        act_type = create(:action_type)
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
  end
  context "Associations" do
    describe "#has_many" do
      it do
        should have_many(:badges)
        should have_many(:assigned_rewards)
        should have_many(:rewards).through(:assigned_rewards)
      end
    end
  end
  describe "#valid?" do
    it "should create a valid action type" do
      expect(create(:action_type)).to be_valid
    end
  end
end
