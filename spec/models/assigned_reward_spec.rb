require "rails_helper"

RSpec.describe AssignedReward, type: :model do
  context "Validation" do
    it do
      should validate_presence_of(:assigned_type).with_message(_(" is not an assignable type."))
    end
  end
  context "Associations" do
    describe "#belongs_to" do
      it "should belong to assigned" do
        should belong_to(:assigned)
      end
      it "should belong to and touch rewards" do
        should belong_to(:reward).touch(true)
      end
    end
  end
end
