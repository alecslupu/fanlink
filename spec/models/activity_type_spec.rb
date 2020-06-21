# frozen_string_literal: true

require "rails_helper"

RSpec.describe ActivityType, type: :model do
  context "Enumerables" do
    it "should be defined for atype" do
      should define_enum_for(:atype).with(%i[beacon image audio post activity_code])
    end
  end
  context "Validation" do
    subject { build(:activity_type) }

    it { should validate_presence_of(:quest_activity).with_message("must exist") }
    it { should validate_presence_of(:atype).with_message(" is not a valid activity type.") }

    context "validates inclusion" do
      it do
        ActivityType.atypes.keys.each do |status|
          expect(build(:activity_type, atype: status)).to be_valid
        end

        expect { build(:activity_type, atype: :invalid_status_form_spec) }.to raise_error(/is not a valid atype/)
      end
    end
  end
  context "Associations" do
    describe "#belongs_to" do
      it do
        should belong_to(:quest_activity).with_foreign_key("activity_id").touch(true)
      end
    end
  end
  context "Valid factory" do
    it { expect(build(:activity_type)).to be_valid }
  end
end
