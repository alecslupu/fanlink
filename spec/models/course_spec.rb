RSpec.describe Course, type: :model do
  context "Validation" do
    describe "should create a valid course" do
      it do
        expect(create(:course)).to be_valid
      end
    end
  end
end
