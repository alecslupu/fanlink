RSpec.describe Course, type: :model do
  context "Validation" do
    describe "should create a valid course" do
      it { expect(create(:course)).to be_valid }
    end
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
