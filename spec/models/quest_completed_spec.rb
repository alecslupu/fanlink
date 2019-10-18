RSpec.describe QuestCompleted, type: :model do
  context "Validation" do
    it "should create a valid quest completed" do
      expect(create(:quest_completed)).to be_valid
    end
  end
end
