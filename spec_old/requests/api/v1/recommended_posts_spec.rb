describe "Recommended Posts (v1)" do

  before(:all) do
    @product = create(:product)
    authors = []
    3.times do
      authors << create(:person, product: @product)
    end
    @num = 8
    @posts = []
    base_time = Time.now
    @num.times.each do |n|
      @posts << create(:post, person: authors.sample, recommended: true, status: :published, created_at: base_time - n.days)
    end
    @not_rec = create(:post, status: :published)
    @not_pub = create(:post, recommended: true)
    @person = create(:person, product: @product)
  end

  before(:each) do
    logout
  end
  #
  # describe "#index" do
  #   it "should get all recommended posts" do
  #     login_as(@person)
  #     get "/posts/recommended", params: { page: 1, per_page: 25 }
  #     expect(response).to be_success
  #     posts = json["recommended_posts"].map { |p| p["id"].to_i }
  #     expect(posts.size).to eq(@num)
  #     expect(posts).not_to include(@not_rec.id)
  #     expect(posts).not_to include(@not_pub.id)
  #   end
  #   it "should get page 1 of recommended posts" do
  #     login_as(@person)
  #     get "/posts/recommended", params: { page: 1, per_page: 2 }
  #     expect(response).to be_success
  #     posts = json["recommended_posts"].map { |p| p["id"].to_i }
  #     expect(posts.size).to eq(2)
  #     expect(posts).to include(@posts.first.id)
  #     expect(posts).to include(@posts[1].id)
  #   end
  #   it "should get page 2 of recommended posts" do
  #     login_as(@person)
  #     get "/posts/recommended", params: { page: 2, per_page: 2 }
  #     expect(response).to be_success
  #     posts = json["recommended_posts"].map { |p| p["id"].to_i }
  #     expect(posts.size).to eq(2)
  #     expect(posts).to include(@posts[2].id)
  #     expect(posts).to include(@posts[3].id)
  #   end
  #   it "should return unauthorized if not logged in" do
  #     get "/posts/recommended", params: { page: 1, per_page: 25 }
  #     expect(response).to be_unauthorized
  #   end
  # end
end
