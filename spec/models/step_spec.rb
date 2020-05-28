# frozen_string_literal: true
RSpec.describe Step, type: :model do
  context "Associations" do
    describe "#should belong to" do
      it do
        should belong_to(:quest).touch(true)
      end
    end

    describe "#should have one" do
      it do
        should have_one(:step_completed).class_name("StepCompleted")
      end
    end

    describe "#should have many" do
      it do
        should have_many(:quest_activities).order(created_at: :desc)
        should have_many(:quest_completions).class_name("QuestCompletion")
        should have_many(:assigned_rewards)
        should have_many(:rewards).through(:assigned_rewards)
        should have_many(:step_unlocks).with_primary_key("uuid").with_foreign_key("step_id")
      end
    end
  end

  context "Validation" do
    describe "should create a valid step" do
      it do
        expect(build(:step)).to be_valid
      end
    end
  end

  context "Enumeration" do
    describe "#should define initial_status enumerables with values of locked and unlocked" do
      it do
        should define_enum_for(:initial_status).with([:locked, :unlocked])
      end
    end
  end
end
