describe "Blocks (v1)" do

  before(:all) do
    blocker = create(:person)
    blocked = create(:person, product: blocked.product)
  end
  describe "#create" do
    it "is pending" do
      expect(1).to be_truthy
    end
  end
end