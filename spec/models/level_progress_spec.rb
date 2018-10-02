RSpec.describe LevelProgress, type: :model do
  context "Valid" do
    it "should create a valid level progress" do
      expect(create(:level_progress)).to be_valid
    end
  end
end
