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
    it "should get all the comments for a post" do
      login_as(@person)
      get "/posts/#{@post.id}/comments"
      expect(response).to be_success
      expect(json["post_comments"].count).to eq(@post.comments.visible.count)
      expect(json["post_comments"].first).to eq(post_comment_json(@post.comments.visible.order(created_at: :desc).first))
      expect(json["post_comments"].map { |pc| pc["id"].to_i }).not_to include(@post_comment_hidden.id)
    end
    it "should get all the comments for a post without comments" do
      login_as(@person)
      get "/posts/#{create(:post, person: @followee2).id}/comments"
      expect(response).to be_success
      expect(json["post_comments"].count).to eq(0)
    end
  end
end