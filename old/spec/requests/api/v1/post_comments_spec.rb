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
      expect(post_comment_json(json["post_comment"])).to be true
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
      expect(post_comment_json(json["post_comment"])).to be true
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
      expect(post_comment_json(json["post_comment"])).to be true
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

  describe "#destroy" do
    it "should delete a comment by an admin" do
      comment = @post.comments.create(person: create(:person, product: @product), body: "bleeb blub")
      expect(comment).to exist_in_database
      login_as(create(:person, role: :admin, product: @product))
      delete "/posts/#{@post.id}/comments/#{comment.id}"
      expect(response).to be_success
      expect(comment).not_to exist_in_database
    end
    it "should delete a comment by creator" do
      creator = create(:person, product: @product)
      comment = @post.comments.create(person: creator, body: "bleeb blub")
      expect(comment).to exist_in_database
      login_as(creator)
      delete "/posts/#{@post.id}/comments/#{comment.id}"
      expect(response).to be_success
      expect(comment).not_to exist_in_database
    end
    it "should not delete a comment by other than creator or admin" do
      creator = create(:person, product: @product)
      comment = @post.comments.create(person: creator, body: "bleeb blub")
      expect(comment).to exist_in_database
      login_as(create(:person))
      delete "/posts/#{@post.id}/comments/#{comment.id}"
      expect(response).to be_not_found
      expect(comment).to exist_in_database
    end
    it "should not delete a comment from another product by admin" do
      creator = create(:person, product: @product)
      comment = @post.comments.create(person: creator, body: "bleeb blub")
      expect(comment).to exist_in_database
      login_as(create(:person, role: :admin, product: create(:product)))
      delete "/posts/#{@post.id}/comments/#{comment.id}"
      expect(response).to be_not_found
      expect(comment).to exist_in_database
    end
    it "should not delete a comment if not logged in" do
      creator = create(:person, product: @product)
      comment = @post.comments.create(person: creator, body: "bleeb blub")
      expect(comment).to exist_in_database
      delete "/posts/#{@post.id}/comments/#{comment.id}"
      expect(response).to be_unauthorized
      expect(comment).to exist_in_database
    end
  end

  describe "#index" do
    it "should get the first page of the comments for a post" do
      login_as(@person)
      pp = 2
      get "/posts/#{@post.id}/comments", params: { page: 1, per_page: pp }
      expect(response).to be_success
      expect(json["post_comments"].count).to eq(pp)
      #expect(json["post_comments"].first).to eq(post_comment_json(@post.comments.visible.order(created_at: :desc).first))
      expect(post_comment_json(json["post_comments"].first)).to be true
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
      @people_list = [create(:person, product: @product, username: "cuser111", email: "cuser1112@example.com"),
                      create(:person, product: @product, username: "cuser112", email: "cuser112@example.com"),
                      create(:person, product: @product, username: "cuser121", email: "cuser121@example.com")]
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
      # expect(pc_json.first).to eq(post_comment_list_json(@list_comments.last))
      expect(post_comment_list_json(pc_json.first)).to be true
    end
    it "should get list of comments paginated at page 2" do
      login_as(@admin)
      get "/post_comments/list", params: { per_page: @per_page, page: 2 }
      expect(response).to be_success
      pc_json = json["post_comments"]
      expect(pc_json.count).to eq(@per_page)
      # expect(pc_json.first).to eq(post_comment_list_json(@list_comments[-3]))
      expect(post_comment_list_json(pc_json.first)).to be true
    end
    it "should get the list of all post comments filtered on body" do
      login_as(@admin)
      fragment = "made up 2"
      get "/post_comments/list", params: { body_filter: fragment }
      expect(response).to be_success
      pc_json = json["post_comments"]
      expect(pc_json.count).to eq(1)
      expect(pc_json.first["body"]).to include(fragment)
    end
    it "should get the list of all post comments filtered on full person username match" do
      login_as(@admin)
      person = @people_list.sample
      get "/post_comments/list", params: { person_filter: person.username }
      expect(response).to be_success
      post_comments = PostComment.where(person_id: person.id)
      pc_json = json["post_comments"]
      expect(pc_json.count).to eq(post_comments.count)
      expect(pc_json.map { |jp| jp["id"] }.sort).to eq(post_comments.map { |p| p.id.to_s }.sort)
    end
    it "should get the list of all post comments filtered on partial person username match" do
      login_as(@admin)
      people = [@people_list.first, @people_list[1] ]
      get "/post_comments/list", params: { person_filter: "cuser11" }
      expect(response).to be_success
      post_comments = PostComment.where(person_id: people)
      pc_json = json["post_comments"]
      expect(pc_json.count).to eq(post_comments.count)
      expect(pc_json.map { |jp| jp["id"] }.sort).to eq(post_comments.map { |p| p.id.to_s }.sort)
    end
    it "should get the list of all post comments filtered on full person email match" do
      login_as(@admin)
      person = @people_list.sample
      get "/post_comments/list", params: { person_filter: person.email }
      expect(response).to be_success
      post_comments = PostComment.where(person_id: person.id)
      pc_json = json["post_comments"]
      expect(pc_json.count).to eq(post_comments.count)
      expect(pc_json.map { |jp| jp["id"] }.sort).to eq(post_comments.map { |p| p.id.to_s }.sort)
    end
    it "should get the list of all post comments filtered on partial person email match" do
      login_as(@admin)
      people = [@people_list.first, @people_list[1] ]
      get "/post_comments/list", params: { person_filter: "112@example" }
      expect(response).to be_success
      post_comments = PostComment.where(person_id: people)
      pc_json = json["post_comments"]
      expect(pc_json.count).to eq(post_comments.count)
      expect(pc_json.map { |jp| jp["id"] }.sort).to eq(post_comments.map { |p| p.id.to_s }.sort)
    end
  end
end
