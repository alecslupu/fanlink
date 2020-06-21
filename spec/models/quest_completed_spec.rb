# frozen_string_literal: true

RSpec.describe QuestCompleted, type: :model do
  context "Validation" do
    it "should create a valid quest completed" do
      expect(build(:quest_completed)).to be_valid
    end
  end
end
