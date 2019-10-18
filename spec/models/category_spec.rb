RSpec.describe Category, type: :model do
  context "Validation" do
    describe "should create a valid category" do
      it { expect(create(:category)).to be_valid }
    end
  end
end
