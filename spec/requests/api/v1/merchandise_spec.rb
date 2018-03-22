describe "Merchandise (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @merch1 = create(:merchandise, product: @product)
    @merch2 = create(:merchandise, product: @product, updated_at: @merch1.updated_at + 1.day)
    @other_product = create(:merchandise, product: create(:product))
    @unavailable = create(:merchandise, product: @product, available: false)
  end

  before(:each) do
    logout
  end

  describe "#index" do
    it "should get the available merchandise" do
      login_as(@person)
      get "/merchandise"
      expect(response).to be_success
      expected = [@merch2, @merch1]
      expect(json["merchandise"].count).to eq(expected.size)
      expect(json["merchandise"].first).to eq(merchandise_json(@merch2))
      expect(json["merchandise"].last).to eq(merchandise_json(@merch1))
    end
    it "should not get the available merchandise if not logged in" do
      get "/merchandise"
      expect(response).to be_unauthorized
    end
  end

  describe "#show" do
    it "should get a single piece of available merchandise" do
      login_as(@person)
      get "/merchandise/#{@merch1.id}"
      expect(response).to be_success
      expect(json["merchandise"]).to eq(merchandise_json(@merch1))
    end
    it "should not get the available merchandise if not logged in" do
      get "/merchandise/#{@merch1.id}"
      expect(response).to be_unauthorized
    end
    it "should not get merchandise from a different product" do
      login_as(@person)
      get "/merchandise/#{@other_product.id}"
      expect(response).to be_not_found
    end
  end
end
