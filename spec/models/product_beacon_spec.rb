RSpec.describe ProductBeacon, type: :model do
  context "Validation" do
    describe "should create a valid product beacon" do
      it do
        expect(create(:product_beacon)).to be_valid
      end
    end
  end
end
