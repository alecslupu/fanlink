require "rails_helper"

RSpec.describe ActivityType, type: :model do
  context "Validation" do
    it do
      should validate_presence_of(:quest_activity).with_message("must exist")
      should validate_presence_of(:atype).with_message(" is not a valid activity type.")
    end
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
      should define_enum_for(:atype)#.with_values([:beacon, :image, :audio, :post, :activity_code])
    end
  end
end
