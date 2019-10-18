RSpec.describe PersonInterest, type: :model do
  context "Validation" do
    describe "should create a valid person interest join" do
      it do
        expect(create(:person_interest)).to be_valid
      end
    end
  end
end
