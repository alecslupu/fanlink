describe "Events (v1)" do

  before(:all) do
    @base_time = Time.now
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @started_month_ago = create(:event, starts_at: @base_time - 1.month)
    @event1 = create(:event, product: @product, starts_at: @base_time + 1.minute)
    @event2 = create(:event, product: @product, starts_at: @base_time + 2.days)
    @starts_in_month = create(:event, name: "in month", product: @product, starts_at: @base_time + 1.month)
    @other_product = create(:event, product: create(:product))
  end

  before(:each) do
    logout
  end

  describe "#index" do
    it "should get all the events" do
      login_as(@person)
      get "/events"
      expect(response).to be_success
      expected = [@started_month_ago, @event1, @event2, @starts_in_month]
      expect(json["events"].count).to eq(expected.size)
      0.upto (expected.size - 1) do |n|
        expect(json["events"][n]).to eq(event_json(expected[n]))
      end
    end
    it "should get events specifying start time" do
      login_as(@person)
      get "/events", params: { start_time: @base_time.strftime("%Y-%m-%d") }
      expect(response).to be_success
      expected = [@event1, @event2, @starts_in_month]
      expect(json["events"].count).to eq(expected.size)
      0.upto (expected.size - 1) do |n|
        expect(json["events"][n]).to eq(event_json(expected[n]))
      end
    end
    it "should not get the events if not logged in" do
      get "/events"
      expect(response).to be_unauthorized
    end
  end

  # describe "#show" do
  #   it "should get a single piece of available merchandise" do
  #     login_as(@person)
  #     get "/merchandise/#{@merch1.id}"
  #     expect(response).to be_success
  #     expect(json["merchandise"]).to eq(merchandise_json(@merch1))
  #   end
  #   it "should not get the available merchandise if not logged in" do
  #     get "/merchandise/#{@merch1.id}"
  #     expect(response).to be_unauthorized
  #   end
  #   it "should not get merchandise from a different product" do
  #     login_as(@person)
  #     get "/merchandise/#{@other_product.id}"
  #     expect(response).to be_not_found
  #   end
  # end
end
