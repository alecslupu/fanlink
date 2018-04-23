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
    it "should create a new post and publish it with a lot of fields normal users really should not have access to but i am told they should" do
      expect_any_instance_of(Post).not_to receive(:post)
      login_as(@person)
      body = "Do you like my body?"
      startat = "2018-01-08T12:15:00Z"
      endat = "2018-06-08T12:15:59Z"
      prior = 123
      rpi = 1
      post "/posts", params: { post: { body: body, global: true, starts_at: startat, ends_at: endat, repost_interval: rpi, status: "rejected", priority: prior } }
      expect(response).to be_success
      post = Post.last
      expect(post.global).to be_truthy
      expect(post.starts_at).to eq(Time.parse(startat))
      expect(post.ends_at).to eq(Time.parse(endat))
      expect(post.repost_interval).to eq(rpi)
      expect(post.status).to eq("rejected")
      expect(post.priority).to eq(prior)
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
      @first_time = Time.zone.now - 10.days
      @total_list_posts.times do |n|
        create(:post, person: @people_list.sample, body: "some body that I made up #{n}", status: Post.statuses.keys.sample, created_at: @first_time + n.days)
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
      expect(json["posts"].first["id"]).to eq(post.id.to_s)
    end
    it "should get the list of all posts filtered on partial body match" do
      login_as(@admin)
      get "/posts/list", params: { body_filter: "some body" }
      expect(response).to be_success
      expect(json["posts"].count).to eq(@total_list_posts)
    end
    it "should get the list of all posts posted at or after some time matching all" do
      login_as(@admin)
      get "/posts/list", params: { posted_after_filter: @first_time.to_s }
      expect(response).to be_success
      expect(json["posts"].count).to eq(@total_list_posts)
    end
    it "should get the list of all posts posted at or after some time matching some" do
      login_as(@admin)
      get "/posts/list", params: { posted_after_filter: (@first_time + 3.days).to_s }
      expect(response).to be_success
      expect(json["posts"].count).to eq(@total_list_posts - 3)
    end
    it "should get the list of all posts posted at or before some time matching all" do
      login_as(@admin)
      get "/posts/list", params: { posted_before_filter: (@first_time + 11.days).to_s }
      expect(response).to be_success
      expect(json["posts"].count).to eq(@total_list_posts)
    end
    it "should get the list of all posts posted on or after some time matching some" do
      login_as(@admin)
      get "/posts/list", params: { posted_before_filter: (@first_time + 3.days).to_s }
      expect(response).to be_success
      expect(json["posts"].count).to eq(@total_list_posts - 7)
    end
    it "should get the list of all posts matching a status" do
      login_as(@admin)
      published_posts = Post.published
      get "/posts/list", params: { status_filter: "published" }
      expect(response).to be_success
      expect(json["posts"].count).to eq(published_posts.count)
    end
    it "should get a list of posts filtered on body and posted_after" do
      login_as(@admin)
      time_to_use = @first_time + 4.days
      posts = Post.where(person: @people_list.first).where("created_at >= ?", time_to_use)
      get "/posts/list", params: { person_id_filter: @people_list.first.id, posted_after_filter: time_to_use.to_s }
      expect(response).to be_success
      expect(json["posts"].count).to eq(posts.count)
    end
    it "should not give you anything if not logged in" do
      get "/posts/list"
      expect(response).to be_unauthorized
    end
    it "should not give you anything if logged in as normal" do
      login_as(@person)
      get "/posts/list"
      expect(response).to be_unauthorized
    end
  end
  describe "#share" do
    let(:post) { create(:post, person: @person, status: :published) }
    it "should get a post without authentication" do
      get "/posts/#{post.id}/share", params: { product: post.product.internal_name }
      expect(response).to be_success
      expect(json["post"]).to eq(post_share_json(post))
    end
    it "should 404 with valid post in different product" do
      post = create(:post, person: create(:person, product: create(:product)), status: :published)
      get "/posts/#{post.id}/share", params: { product: @product.internal_name }
      expect(response).to be_not_found
    end
    it "should 404 with invalid post id" do
      use_id = (Post.count > 0) ? Post.last.id + 1 : 1
      get "/posts/#{use_id}/share", params: { product: @product.internal_name }
      expect(response).to be_not_found
    end
    it "should 422 with invalid product" do
      get "/posts/#{post.id}/share", params: { product: "thiscannotpossiblyexist" }
      expect(response).to be_unprocessable
    end
    it "should 422 with missing product" do
      get "/posts/#{post.id}/share", params: { product: "thiscannotpossiblyexist" }
      expect(response).to be_unprocessable
    end
    it "should get a post for different product than logged in" do
      login_as(create(:person, product: create(:product)))
      get "/posts/#{post.id}/share", params: { product: post.product.internal_name }
      expect(response).to be_success
      expect(json["post"]).to eq(post_share_json(post))
    end
    it "should 404 on an unpublished post" do
      post = create(:post)
      Post.statuses.keys.each do |s|
        next if s == "published"
        post.update_column(:status, Post.statuses[s])
        get "/posts/#{post.id}/share", params: { product: post.product.internal_name }
        expect(response).to be_not_found
      end
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

  describe "#update" do
    let(:newbody) { "Do you like my new body?" }
    let(:global) { true }
    let(:starts_at) { "2018-03-12T18:55:30Z" }
    let(:ends_at) { "2018-03-13T18:55:30Z" }
    let(:repost_interval) { 5 }
    let(:status) { "published" }
    let(:priority) { 2 }
    let(:admin) { create(:person, role: :admin, product: @person.product) }
    let(:post) { create(:post, person: @person) }
    it "should let admin update a post" do
      login_as(admin)
      post = create(:post, person: @person)
      patch "/posts/#{post.id}", params: { post: { body: newbody, global: global, starts_at: starts_at, ends_at: ends_at,
                                                   repost_interval: repost_interval, status: status, priority: priority } }
      expect(response).to be_success
      post.reload
      expect(post.body).to eq(newbody)
      expect(post.global).to eq(global)
      expect(post.starts_at).to eq(Time.parse(starts_at))
      expect(post.ends_at).to eq(Time.parse(ends_at))
      expect(post.repost_interval).to eq(repost_interval)
      expect(post.status).to eq(status)
      expect(post.priority).to eq(priority)
    end
    it "should not let normal update a post" do
      login_as(@person)
      orig = post.body
      patch "/posts/#{post.id}", params: { post: { body: "notchanged", global: global, starts_at: starts_at, ends_at: ends_at,
                                                   repost_interval: repost_interval, status: status, priority: priority } }
      expect(response).to be_unauthorized
      expect(post.body).to eq(orig)
    end
    it "should not let not logged in update a post" do
      orig = post.body
      patch "/posts/#{post.id}", params: { post: { body: "notchanged", global: global, starts_at: starts_at, ends_at: ends_at,
                                                   repost_interval: repost_interval, status: status, priority: priority } }
      expect(response).to be_unauthorized
      expect(post.body).to eq(orig)
    end
  end

end
