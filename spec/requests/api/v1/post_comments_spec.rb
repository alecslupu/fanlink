describe "PostComments (v1)" do

  before(:all) do
    @product = Product.first || create(:product)
    @person = create(:person, product: @product)
    @followee1 = create(:person, product: @person.product)
    @followee2 = create(:person, product: @person.product)
    @nonfollowee = create(:person, product: @person.product)
    @person.follow(@followee1)
    @person.follow(@followee2)
    @post = create(:post, person_id: @followee1.id, body: "a post")
    @post_comment1 = @post.comments.create(body: "a comment", person: @person)
    @post_comment2 = @post.comments.create(body: "another comment", person: @person)
    @post_comment3 = @post.comments.create(body: "a comment", person: @person)
    @post_comment4 = @post.comments.create(body: "another comment", person: @person)
    @post_comment_hidden = @post.comments.create(body: "another comment", person: @person, hidden: true)
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a post comment" do
      login_as(@person)
      expect {
        post "/posts/#{@post.id}/comments", params: { post_comment: { body: "a comment" } }
      }.to change { @post.comments.count }.by(1)
      expect(response).to be_success
      expect(json["post_comment"]).to eq(post_comment_json(@post.comments.last))
    end
    it "should create a post comment with one mention" do
      login_as(@person)
      expect {
        post "/posts/#{@post.id}/comments", params: { post_comment: { body: "a comment", mentions: [
                                                { person_id: @followee2.id, location: 1, length: 2 } ] } }
      }.to change { @post.comments.count }.by(1)
      expect(response).to be_success
      comment = @post.comments.last
      expect(comment.mentions.count).to eq(1)
      expect(json["post_comment"]).to eq(post_comment_json(comment))
    end
    it "should create a post comment with multiple mentions" do
      login_as(@person)
      expect {
        post "/posts/#{@post.id}/comments", params: { post_comment: { body: "a comment", mentions: [
            { person_id: @followee2.id, location: 1, length: 2 },
            { person_id: @followee1.id, location: 11, length: 3 }
        ] } }
      }.to change { @post.comments.count }.by(1)
      expect(response).to be_success
      comment = @post.comments.last
      expect(comment.mentions.count).to eq(2)
      expect(json["post_comment"]).to eq(post_comment_json(comment))
    end
    it "should not create a post comment if not logged in" do
      expect {
        post "/posts/#{@post.id}/comments", params: { post_comment: { body: "a comment" } }
      }.to change { @post.comments.count }.by(0)
      expect(response).to be_unauthorized
    end
    it "should not create a post comment if logged in to a different product" do
      person = create(:person, product: create(:product))
      login_as(person)
      expect {
        post "/posts/#{@post.id}/comments", params: { post_comment: { body: "a comment" } }
      }.to change { @post.comments.count }.by(0)
      expect(response).to be_not_found
    end
  end

  describe "#index" do
    it "should get the first page of the comments for a post" do
      login_as(@person)
      pp = 2
      get "/posts/#{@post.id}/comments", params: { page: 1, per_page: pp }
      expect(response).to be_success
      expect(json["post_comments"].count).to eq(pp)
      expect(json["post_comments"].first).to eq(post_comment_json(@post.comments.visible.order(created_at: :desc).first))
    end
    it "should get all the comments for a post without comments" do
      login_as(@person)
      get "/posts/#{create(:post, person: @followee2).id}/comments"
      expect(response).to be_success
      expect(json["post_comments"].count).to eq(0)
    end
  end
  describe "#list" do
    before(:all) do
      Post.for_product(@product).destroy_all
      @admin = create(:person, role: :admin)
      @people_list = [create(:person, product: @product, username: "user111", email: "user1112@example.com"),
                      create(:person, product: @product, username: "user112", email: "user112@example.com"),
                      create(:person, product: @product, username: "user121", email: "user121@example.com")]
      @total_list_posts = 3
      @first_time = Time.zone.now - 30.days
      @list_posts = []
      @total_list_posts.times do |n|
        @list_posts << create(:post, person: @people_list.sample, body: "some body that I made up #{n}", status: Post.statuses.keys.sample, created_at: @first_time + n.days)
      end
      @total_list_comments = 10
      @list_comments = []
      @total_list_comments.times do |n|
        @list_comments << @list_posts.sample.comments.create(person: @people_list.sample, body: "some body that I made up #{n}", created_at: @first_time + (@total_list_posts + n).days)
      end
      @per_page = 2
      @page = 1
    end
    it "should get the paginated list of all comments unfiltered" do
      login_as(@admin)
      get "/post_comments/list", params: { per_page: @per_page, page: @page }
      expect(response).to be_success
      pc_json = json["post_comments"]
      expect(pc_json.count).to eq(@per_page)
      expect(pc_json.first).to eq(list_post_comment_json(@list_comments.last))
    end
    # it "should get the list of all posts unfiltered" do
    #   login_as(@admin)
    #   get "/posts/list"
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(@total_list_posts)
    # end
    # it "should get list paginated at page 1" do
    #   login_as(@admin)
    #   pp = 2
    #   get "/posts/list", params: { page: 1, per_page: pp }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(pp)
    #   expect(json["posts"].first).to eq(post_list_json(@list_posts.last))
    #   expect(json["posts"].last).to eq(post_list_json(@list_posts[-2]))
    # end
    # it "should get list paginated at page 2" do
    #   login_as(@admin)
    #   pp = 2
    #   get "/posts/list", params: { page: 2, per_page: pp }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(pp)
    #   expect(json["posts"].first).to eq(post_list_json(@list_posts[-3]))
    #   expect(json["posts"].last).to eq(post_list_json(@list_posts[-4]))
    # end
    # it "should get the list of all posts filtered on person_id" do
    #   login_as(@admin)
    #   person = @people_list.sample
    #   get "/posts/list", params: { person_id_filter: person.id }
    #   expect(response).to be_success
    #   posts = Post.where(person_id: person.id)
    #   expect(json["posts"].count).to eq(posts.count)
    #   expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    # end
    # it "should get the list of all posts filtered on full person username match" do
    #   login_as(@admin)
    #   person = @people_list.sample
    #   get "/posts/list", params: { person_filter: person.username }
    #   expect(response).to be_success
    #   posts = Post.where(person_id: person.id)
    #   expect(json["posts"].count).to eq(posts.count)
    #   expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    # end
    # it "should get the list of all posts filtered on partial person username match" do
    #   login_as(@admin)
    #   people = [@people_list.first, @people_list[1] ]
    #   get "/posts/list", params: { person_filter: "user11" }
    #   expect(response).to be_success
    #   posts = Post.where(person_id: people)
    #   expect(json["posts"].count).to eq(posts.count)
    #   expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    # end
    # it "should get the list of all posts filtered on full person email match" do
    #   login_as(@admin)
    #   person = @people_list.sample
    #   get "/posts/list", params: { person_filter: person.email }
    #   expect(response).to be_success
    #   posts = Post.where(person_id: person.id)
    #   expect(json["posts"].count).to eq(posts.count)
    #   expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    # end
    # it "should get the list of all posts filtered on partial person email match" do
    #   login_as(@admin)
    #   people = [@people_list.first, @people_list[1] ]
    #   get "/posts/list", params: { person_filter: "112@example" }
    #   expect(response).to be_success
    #   posts = Post.where(person_id: people)
    #   expect(json["posts"].count).to eq(posts.count)
    #   expect(json["posts"].map { |jp| jp["id"] }.sort).to eq(posts.map { |p| p.id.to_s }.sort)
    # end
    # it "should get the list of all posts filtered on full body match" do
    #   login_as(@admin)
    #   post = Post.for_product(@product).sample
    #   get "/posts/list", params: { body_filter: post.body }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(1)
    #   expect(json["posts"].first["id"]).to eq(post.id.to_s)
    # end
    # it "should get the list of all posts filtered on partial body match" do
    #   login_as(@admin)
    #   get "/posts/list", params: { body_filter: "some body" }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(@total_list_posts)
    # end
    # it "should get the list of all posts posted at or after some time matching all" do
    #   login_as(@admin)
    #   get "/posts/list", params: { posted_after_filter: @first_time.to_s }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(@total_list_posts)
    # end
    # it "should get the list of all posts posted at or after some time matching some" do
    #   login_as(@admin)
    #   get "/posts/list", params: { posted_after_filter: (@first_time + 3.days).to_s }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(@total_list_posts - 3)
    # end
    # it "should get the list of all posts posted at or before some time matching all" do
    #   login_as(@admin)
    #   get "/posts/list", params: { posted_before_filter: (@first_time + 11.days).to_s }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(@total_list_posts)
    # end
    # it "should get the list of all posts posted on or after some time matching some" do
    #   login_as(@admin)
    #   get "/posts/list", params: { posted_before_filter: (@first_time + 3.days).to_s }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(@total_list_posts - 7)
    # end
    # it "should get the list of all posts matching a status" do
    #   login_as(@admin)
    #   published_posts = Post.published
    #   get "/posts/list", params: { status_filter: "published" }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(published_posts.count)
    # end
    # it "should get a list of posts filtered on body and posted_after" do
    #   login_as(@admin)
    #   time_to_use = @first_time + 4.days
    #   posts = Post.where(person: @people_list.first).where("created_at >= ?", time_to_use)
    #   get "/posts/list", params: { person_id_filter: @people_list.first.id, posted_after_filter: time_to_use.to_s }
    #   expect(response).to be_success
    #   expect(json["posts"].count).to eq(posts.count)
    # end
    # it "should not give you anything if not logged in" do
    #   get "/posts/list"
    #   expect(response).to be_unauthorized
    # end
    # it "should not give you anything if logged in as normal" do
    #   login_as(@person)
    #   get "/posts/list"
    #   expect(response).to be_unauthorized
    # end
  end
end