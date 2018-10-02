RSpec.describe PersonReward, type: :model do
  context "Validation" do
    describe "should create a valid person reward join" do
      it do
        expect(create(:person_reward)).to be_valid
      end
    end
  end
end
