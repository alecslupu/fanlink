describe "Recommended People (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @recommended1 = create(:person, product: @product, recommended: true)
    @recommended2 = create(:person, product: @product, recommended: true)
    @person = create(:person, product: @product)
    create(:person, product: @product)
  end

  before(:each) do
    logout
  end
  #
  # describe "#index" do
  #   it "should get all recommended people" do
  #     login_as(@person)
  #     get "/people/recommended"
  #     expect(response).to be_success
  #     people = json["recommended_people"].map { |p| p["id"].to_i }
  #     expect(people.size).to eq(2)
  #     expect(people.sort).to eq([@recommended1.id, @recommended2.id])
  #   end
  #   it "should exclude the current user" do
  #     login_as(@recommended1)
  #     get "/people/recommended"
  #     expect(response).to be_success
  #     people = json["recommended_people"].map { |p| p["id"].to_i }
  #     expect(people.size).to eq(1)
  #     expect(people.first).to eq(@recommended2.id)
  #   end
  #   it "should exclude followees of the current user" do
  #     followee = create(:person, recommended: true)
  #     @person.follow(followee)
  #     login_as(@person)
  #     get "/people/recommended"
  #     expect(response).to be_success
  #     people = json["recommended_people"].map { |p| p["id"].to_i }
  #     expect(people.size).to eq(2)
  #     expect(people.sort).to eq([@recommended1.id, @recommended2.id])
  #   end
  # end
end
