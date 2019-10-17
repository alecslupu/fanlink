RSpec.describe QuestActivity, type: :model do
  context "Validation" do
    it "should create a valid quest activity" do
      expect(create(:quest_activity)).to be_valid
    end
  end

  context "Methods" do
    describe "#product" do
      pending
    end
  end
end
