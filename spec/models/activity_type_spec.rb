require "rails_helper"

RSpec.describe ActivityType, type: :model do

  context "Validation" do
    subject { build(:activity_type) }

    it { should validate_presence_of(:quest_activity).with_message("must exist") }
    it { should validate_presence_of(:atype).with_message(" is not a valid activity type.") }
    it { should validate_inclusion_of(:atype).in_array(%i(beacon image audio post activity_code)) }
  end
  context "Associations" do
    describe "#belongs_to" do
      it do
        should belong_to(:quest_activity).with_foreign_key('activity_id').touch(true)
      end
    end
  end
  context "Enumerables" do
    it "should be defined for atype" do
      should define_enum_for(:atype).with(%i[ beacon image audio post activity_code ])
    end
  end
  context "Valid factory" do
    it { expect(create(:activity_type)).to be_valid }
  end
end
