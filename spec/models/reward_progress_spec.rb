# frozen_string_literal: true
RSpec.describe RewardProgress, type: :model do
  context "Associations" do
    describe "should belong to" do
      it "#person" do
        should belong_to(:person).touch(true)
      end

      it "#reward" do
        should belong_to(:reward)
      end
    end
  end

  context "Validation" do
    describe "should create a valid reward progress" do
      it do
        expect(build(:reward_progress)).to be_valid
      end
    end
  end
end
