# frozen_string_literal: true

RSpec.describe StepCompleted, type: :model do
  context "Associations" do
    describe "should belong to" do
      it "#product" do
        should belong_to(:step).touch(true)
      end

      it "#person" do
        should belong_to(:person).touch(true)
      end
    end
  end

  context "Validation" do
    describe "should create a valid step completed entry" do
      it do
        reward = create(:badge_reward)
        ar = create(:assigned_as_step, reward: reward)
        expect(build(:step_completed, step_id: ar.assigned_id)).to be_valid
      end
    end
  end
end
