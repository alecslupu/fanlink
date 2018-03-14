RSpec.describe Merchandise, type: :model do

  before(:all) do
    @name = "abc"
    @merchandise = create(:merchandise, name: @name)
    ActsAsTenant.current_tenant = @merchandise.product
  end

  describe "#create" do
    it "should create valid merchandise" do
      expect(@merchandise).to be_valid
    end
    it "should not let you create merchandise without a product" do
      ActsAsTenant.without_tenant do
        merch = build(:merchandise, product: nil)
        expect(merch).not_to be_valid
        expect(merch.errors["product"]).not_to be_empty
      end
    end
  end

end
