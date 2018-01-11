describe "Posts (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new post" do
      expect_any_instance_of(Api::V1::PostsController).to receive(:post_post).and_return(true)
      login_as(@person)
      body = "Do you like my body?"
      post "/posts", params: { message: { body: body } }
      expect(response).to be_success
      post = Post.last
      expect(post.person).to eq(@person)
      expect(post.body).to eq(body)
      expect(json["post"]).to eq(post_json(post))
    end
    it "should not create a new post if not logged in" do
      expect_any_instance_of(Api::V1::MessagesController).not_to receive(:post_post)
      post "/posts", params: { message: { body: "not gonna see my body" } }
      expect(response).to be_unauthorized
    end
  end
end