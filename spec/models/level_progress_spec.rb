RSpec.describe LevelProgress, type: :model do
  context "Valid" do
    it { expect(create(:level_progress)).to be_valid }
  end
end
