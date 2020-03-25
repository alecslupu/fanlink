describe "Posts (v2)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @followee1 = create(:person, product: @person.product)
    @followee2 = create(:person, product: @person.product)
    @nonfollowee = create(:person, product: @person.product)
    @person.follow(@followee1)
    @person.follow(@followee2)
  end

  before(:each) do
    logout
  end

  describe "#index" do
    before(:all) do
      @index_posts = []
      @total_index_posts = 10
      @total_index_posts.times do |n|
        @index_posts << create(:post, status: :published, person: [@followee1, @followee2].sample, body:  "This is post #{n + 1}")
      end
      @expired_index_post = create(:post, person: @followee1, starts_at: Time.now - 10.days, ends_at: Time.now - 1.day)
      @premature_index_post = create(:post, person: @followee2, starts_at: Time.now + 1.days)
      @nonfollowed_index_post = create(:post, person: @nonfollowee)
      @rejected_index_post = create(:post, person: @followee1, status: :rejected)
      @per_page = 2
    end
    it "should get a list of posts with page 1" do
      login_as(@person)
      get "/posts", params: { page: 1, per_page: @per_page }
      expect(response).to be_success
      expected_posts = [@index_posts.last, @index_posts[-2]]
      expect(json["posts"].count).to eq(expected_posts.size)
      expect(json["posts"].map { |p| p["id"] }).to eq(expected_posts.map { |p| p.id.to_s })
    end
    it "should get a list of posts with a couple more per page" do
      login_as(@person)
      get "/posts", params: { page: 1, per_page: @per_page + 2 }
      expect(response).to be_success
      expected_posts = [@index_posts.last, @index_posts[-2], @index_posts[-3], @index_posts[-4] ]
      expect(json["posts"].count).to eq(expected_posts.size)
      expect(json["posts"].map { |p| p["id"] }).to eq(expected_posts.map { |p| p.id.to_s })
    end
    it "should get a list of posts with no per page param" do
      login_as(@person)
      get "/posts", params: { page: 1 }
      expect(response).to be_success
      expected_posts = @index_posts.reverse
      expect(json["posts"].count).to eq(expected_posts.size)
      expect(json["posts"].map { |p| p["id"] }).to eq(expected_posts.map { |p| p.id.to_s })
    end
    it "should get a list of posts with page 1 if no page param" do
      login_as(@person)
      get "/posts", params: { per_page: @per_page }
      expect(response).to be_success
      expected_posts = [@index_posts.last, @index_posts[-2]]
      expect(json["posts"].count).to eq(expected_posts.size)
      expect(json["posts"].map { |p| p["id"] }).to eq(expected_posts.map { |p| p.id.to_s })
    end
    it "should get a list of posts with page 2" do
      login_as(@person)
      get "/posts", params: { page: 2, per_page: @per_page }
      expect(response).to be_success
      expected_posts = [@index_posts[-3], @index_posts[-4]]
      expect(json["posts"].count).to eq(expected_posts.size)
      expect(json["posts"].map { |p| p["id"] }).to eq(expected_posts.map { |p| p.id.to_s })
    end
    it "should return correct language if device language provided" do
      lan = "es"
      headers = { "Accept-Language" => (lan + "-spa") } #letters dont matter because we should be just using first two characters
      translation = "En espagnol"
      sample_post = @index_posts.last
      sample_post.body = { lan => translation }
      sample_post.save
      login_as(@person)
      get "/posts", params: { page: 1, per_page: @per_page }, headers: headers
      expect(response).to be_success
      post_json = json["posts"].find { |p| p["id"] == @index_posts.last.id.to_s }
      expect(post_json["body"]).to eq(translation)
    end
    it "should not get the list if not logged in" do
      get "/posts", params: { page: 1 }
      expect(response).to be_unauthorized
    end
    it "should get page 1 of a list of posts for a person" do
      person = create(:person, product: @person.product)
      num = 4
      posts = []
      num.times do
        posts << create(:post, person: person, status: :published)
      end
      create(:post, person: person, status: :rejected)
      create(:post, person: person, starts_at: Time.now + 1.day)
      create(:post, person: person, ends_at: Time.now - 1.day)
      login_as(@person)
      get "/posts", params: { page: 1, per_page: 2, person_id: person.id }
      expect(response).to be_success
      expect(json["posts"].count).to eq(2)
      expect(json["posts"].map { |p| p["id"] }).to eq([posts.last, posts[-2] ].map { |p| p.id.to_s })
    end
    it "should return unprocessable for a badly formed person id" do
      login_as(@person)
      get "/posts", params: { person_id: "whodat" }
      expect(response).to be_unprocessable
      expect(json["errors"]).not_to be_empty
    end
    it "should return unprocessable for a nonexistent person" do
      login_as(@person)
      get "/posts", params: { person_id: Person.last.id + 1 }
      expect(response).to be_unprocessable
      expect(json["errors"]).not_to be_empty
    end
  end
end
