RSpec.describe Merchandise, type: :model do
  before(:all) do
    @name = "abc"
    @merchandise = create(:merchandise, name: @name)
    @product = @merchandise.product
    ActsAsTenant.current_tenant = @product
  end

  context "Valid" do
    it "should create a valid merchandise" do
      expect(create(:merchandise)).to be_valid
    end
  end

  describe "#create" do
    it "should not let you create merchandise without a product" do
      ActsAsTenant.without_tenant do
        merch = build(:merchandise, product: nil)
        expect(merch).not_to be_valid
        expect(merch.errors["product"]).not_to be_empty
      end
    end
  end

  describe "#priority" do
    let!(:merch1) { create(:merchandise, priority: 1) }
    let!(:merch2) { create(:merchandise, priority: 2) }
    it "should not adjust priorities if priority is 0" do
      merch0 = create(:merchandise)
      create(:merchandise)
      expect(merch0.reload.priority).to eq(0)
    end
    it "should adjust priorities if priority is greater than 0 and there is merch of equal priority" do
      merch_other = ActsAsTenant.with_tenant(create(:product)) {
        create(:merchandise, priority: 1)
      }
      create(:merchandise, priority: 1)
      expect(merch1.reload.priority).to eq(2)
      expect(merch2.reload.priority).to eq(3)
      expect(merch_other.reload.priority).to eq(1)
    end
    it "should not adjust priorities if priority is greater than 0 but there is no merch of equal priority" do
      prod = create(:product)
      ActsAsTenant.with_tenant(prod) do
        _merch2 = create(:merchandise, priority: 2)
        _merch3 = create(:merchandise, priority: 3)
        create(:merchandise, priority: 1)
        expect(_merch2.reload.priority).to eq(2)
        expect(_merch3.reload.priority).to eq(3)
      end
    end
  end
end
