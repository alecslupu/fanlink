RSpec.describe Interest, type: :model do
  context "Validation" do
    describe "should create a valid Interest" do
      it do
        expect(create(:interest)).to be_valid
      end
    end
  end
end
