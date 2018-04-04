describe "Posts (v1)" do

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

  describe "#create" do
    it "should create a new post and publish it" do
      expect_any_instance_of(Post).to receive(:post)
      login_as(@person)
      body = "Do you like my body?"
      post "/posts", params: { post: { body: body } }
      expect(response).to be_success
      post = Post.last
      expect(post.person).to eq(@person)
      expect(post.body).to eq(body)
      expect(post.published?).to be_truthy
      expect(json["post"]).to eq(post_json(post))
    end
    it "should not create a new post if not logged in" do
      expect_any_instance_of(Post).not_to receive(:post)
      post "/posts", params: { post: { body: "not gonna see my body" } }
      expect(response).to be_unauthorized
    end
  end

  describe "#destroy" do
    it "should delete message from original creator" do
      expect_any_instance_of(Post).to receive(:delete_real_time)
      login_as(@person)
      post = create(:post, person: @person, status: :published)
      delete "/posts/#{post.id}"
      expect(response).to be_success
      expect(post.reload.deleted?).to be_truthy
    end
    it "should not delete post from someone else" do
      expect_any_instance_of(Post).to_not receive(:delete_real_time)
      p = create(:person)
      login_as(@person)
      post = create(:post, person: p, status: :published)
      delete "/posts/#{post.id}"
      expect(response).to be_not_found
      expect(post.reload.published?).to be_truthy
    end
    it "should not delete post if not logged in" do
      expect_any_instance_of(Post).to_not receive(:delete_real_time)
      post = create(:post, person: @person, status: :published)
      delete "/posts/#{post.id}"
      expect(response).to be_unauthorized
    end
  end

  # with messages we stubbed the scope and tested that separately, here we are essentially testing the scopes
  # and controller action together for no particular reason
  describe "#index" do
    created_in_range = Date.parse("2018-01-02").end_of_day
    let!(:post11) { create(:post, person: @followee1, status: :published, created_at: created_in_range - 1.hour) }
    let!(:post12) { create(:post, person: @followee1, status: :published, created_at: created_in_range - 30.minutes) }
    let!(:post21) { create(:post, person: @followee2, status: :published, created_at: created_in_range) }
    let!(:post22) { create(:post, person: @followee2, status: :published, created_at: created_in_range + 30.minutes) }
    let!(:postloggedin) { create(:post, person: @person, status: :published, created_at: created_in_range + 31.minutes) }
    let!(:postnofollow) { create(:post, person: @nonfollowee, status: :published, created_at: created_in_range) }
    let!(:postrejected) { create(:post, person: @followee1, status: :rejected, created_at: created_in_range) }
    let!(:postexpired) { create(:post, person: @followee2, status: :published, ends_at: Time.zone.now - 1.hour, created_at: created_in_range) }
    let!(:postpredates) { create(:post, person: @followee1, status: :published, created_at: Date.parse("2017-12-31")) }
    let!(:postpremature) { create(:post, person: @followee2, status: :published, starts_at: Time.now + 1.hour, created_at: created_in_range) }
    let(:from) { "2018-01-01" }
    let(:to) { "2018-01-03" }
    it "should get a list of posts for a date range without limit" do
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: to }
      expect(response).to be_success
      expect(json["posts"].map { |p| p["id"] }).to eq([ postloggedin.id.to_s, post22.id.to_s, post21.id.to_s, post12.id.to_s, post11.id.to_s])
    end
    it "should get a list of posts for a date range with limit" do
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: to, limit: 2 }
      expect(response).to be_success
      expect(json["posts"].map { |p| p["id"] }).to eq([postloggedin.id.to_s, post22.id.to_s])
    end
    it "should not include posts from blocked person" do
      blocked = create(:person, product: @person.product)
      post = create(:post, person: blocked, status: :published)
      @person.block(blocked)
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: "2019-12-31" }
      expect(response).to be_success
      expect(json["posts"].map { |p| p["id"] }).not_to include(post.id)
    end
    it "should return correct language if device language provided" do
      lan = "es"
      headers = { "Accept-Language" => (lan + "-spa") } #letters dont matter because we should be just using first two characters
      translation = "En espagnol"
      post11.body = { lan => translation }
      post11.save
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: to }, headers: headers
      expect(response).to be_success
      post11_json = json["posts"].find { |p| p["id"] == post11.id.to_s }
      expect(post11_json["body"]).to eq(translation)
    end
    it "should not get the list if not logged in" do
      get "/posts", params: { from_date: from, to_date: to, limit: 2 }
      expect(response).to be_unauthorized
    end
    it "should return unprocessable if invalid from date" do
      login_as(@person)
      get "/posts", params: { from_date: "what's this", to_date: to }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("invalid date")
    end
    it "should return unprocessable if invalid to date" do
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: "nonsense" }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("invalid date")
    end
    it "should return unprocessable if missing dates" do
      login_as(@person)
      get "/posts", params: {}
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Missing")
    end
    it "should return unprocessable if missing from date" do
      login_as(@person)
      get "/posts", params: { to_date: to }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Missing")
    end
    it "should return unprocessable if missing to date" do
      login_as(@person)
      get "/posts", params: { from_date: from }
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Missing")
    end
    it "should get a list of posts for a person" do
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: to, person_id: @followee1.id }
      expect(response).to be_success
      expect(json["posts"].map { |p| p["id"] }).to eq([ post12.id.to_s, post11.id.to_s])
    end
    it "should return unprocessable for a badly formed person id" do
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: to, person_id: "whodat" }
      expect(response).to be_unprocessable
      expect(json["errors"]).not_to be_empty
    end
    it "should return unprocessable for a nonexistent person" do
      login_as(@person)
      get "/posts", params: { from_date: from, to_date: to, person_id: Person.last.id + 1 }
      expect(response).to be_unprocessable
      expect(json["errors"]).not_to be_empty
    end
  end

  describe "#list" do
    before(:all) do
      Post.for_product(@product).destroy_all
      @admin = create(:person, role: :admin)
      @people_list = [create(:person, product: @product, username: "user111", email: "user1112@example.com"),
                      create(:person, product: @product, username: "user112", email: "user112@example.com"),
                      create(:person, product: @product, username: "user121", email: "user121@example.com")]
      @total_list_posts = 10
      @total_list_posts.times do |n|
        create(:post, person: @people_list.sample)
      end
    end
    it "should get the list of all posts unfiltered" do
      login_as(@admin)
      get "/posts/list"
      expect(response).to be_success
      expect(json["posts"].count).to eq(@total_list_posts)
    end
    it "should get the list of all posts unfiltered" do
      login_as(@admin)
      get "/posts/list"
      expect(response).to be_success
      expect(json["posts"].count).to eq(@total_list_posts)
    end
    it "should get the list of all posts filtered on person_id" do
      login_as(@admin)
      person = @people_list.sample
      get "/posts/list", params: { person_id_filter: person.id }
      expect(response).to be_success
      posts = Post.where(person_id: person.id)
      expect(json["posts"].count).to eq(posts.count)
      expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    end
    it "should get the list of all posts filtered on full person username match" do
      login_as(@admin)
      person = @people_list.sample
      get "/posts/list", params: { person_filter: person.username }
      expect(response).to be_success
      posts = Post.where(person_id: person.id)
      expect(json["posts"].count).to eq(posts.count)
      expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    end
    it "should get the list of all posts filtered on partial person username match" do
      login_as(@admin)
      people = [@people_list.first, @people_list[1] ]
      get "/posts/list", params: { person_filter: "user11" }
      expect(response).to be_success
      posts = Post.where(person_id: people)
      expect(json["posts"].count).to eq(posts.count)
      expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    end
    it "should get the list of all posts filtered on full person email match" do
      login_as(@admin)
      person = @people_list.sample
      get "/posts/list", params: { person_filter: person.email }
      expect(response).to be_success
      posts = Post.where(person_id: person.id)
      expect(json["posts"].count).to eq(posts.count)
      expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    end
    it "should get the list of all posts filtered on partial person email match" do
      login_as(@admin)
      people = [@people_list.first, @people_list[1] ]
      get "/posts/list", params: { person_filter: "112@example" }
      expect(response).to be_success
      posts = Post.where(person_id: people)
      expect(json["posts"].count).to eq(posts.count)
      expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    end
    it "should get the list of all posts filtered on full body match" do
      login_as(@admin)
      post = Post.for_product(@product).sample
      get "/posts/list", params: { body_filter: post.body }
      expect(response).to be_success
      expect(json["posts"].count).to eq(1)
      expect(json["posts"].first.id).to eq(post.id.to_s)
    end
  end

  describe "#show" do
    it "should get a visible post" do
      post = create(:post, person: @person, status: :published)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post))
    end
    it "should get a visible post with reaction counts" do
      post = create(:post, person: @person, status: :published)
      1.upto 4 do
        create(:post_reaction, post: post)
      end
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post))
    end
    it "should include current user reaction" do
      post = create(:post, person: @person, status: :published)
      reaction = create(:post_reaction, post: post, person: @person)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post, nil, reaction))
      expect(json["post"]["post_reaction"]).not_to be_nil
    end
    it "should return english language body if no device language provided and english exists" do
      post = create(:post, person: @person, status: :published)
      english = "This is English"
      post.body = { "en" => english }
      post.save
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]["body"]).to eq(english)
    end
    it "should return original language body if no device language provided and no english exists" do
      post = create(:post, person: @person, status: :published)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]["body"]).to eq(post.body(Post::DEFAULT_LANG))
    end
    it "should return correct language body if device language provided" do
      lan = "es"
      headers = { "Accept-Language" => (lan + "-spa") } #letters dont matter because we should be just using first two characters
      post = create(:post, person: @person, status: :published)
      translation = "En espagnol"
      post.body = { lan => translation }
      post.save
      login_as(@person)
      get "/posts/#{post.id}", headers: headers
      expect(response).to be_success
      expect(json["post"]["body"]).to eq(translation)
    end
    it "should not get a deleted post" do
      post = create(:post, person: @person, status: :deleted)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should not get a rejected post" do
      post = create(:post, person: @person, status: :rejected)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should get a post with a start date and no end date" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now - 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post))
    end
    it "should get an unexpired post with no start date and an end date" do
      post = create(:post, person: @person, status: :published, ends_at: Time.now + 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post))
    end
    it "should get an unexpired post with both dates" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now - 1.hour, ends_at: Time.now + 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_success
      expect(json["post"]).to eq(post_json(post))
    end
    it "should not get a premature post with a start date and no end date" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now + 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should not get an expired post with no start date and an end date" do
      post = create(:post, person: @person, status: :published, ends_at: Time.now - 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should not get a premature post with both dates" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now + 1.hour, ends_at: Time.now + 2.hours)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
    it "should not get an expired post with both dates" do
      post = create(:post, person: @person, status: :published, starts_at: Time.now - 3.hours, ends_at: Time.now - 1.hour)
      login_as(@person)
      get "/posts/#{post.id}"
      expect(response).to be_not_found
    end
  end
end
