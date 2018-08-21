describe "Levels (v1)" do

  describe "#index" do
    it "should return all levels" do
      level1 = create(:level, points: 20)
      level2 = create(:level, product: level1.product, points: 10)
      create(:level, product: create(:product))
      login_as(create(:person))
      get "/levels"
      expect(response).to be_success
      expect(json["levels"].count).to eq(2)
      l1 = json["levels"].first
      expect(json["levels"].first).to eq(level_v1_json(level2))
      expect(json["levels"].last).to eq(level_v1_json(level1))
    end
  end
end
