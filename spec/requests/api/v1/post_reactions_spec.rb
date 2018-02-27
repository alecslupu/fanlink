describe "PostReactions (v1)" do

  before(:all) do
    @post = create(:post)
    @person = create(:person, product: @post.product)
    @reaction = "U+1F600"
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new reaction" do
      login_as(@person)
      post "/posts/#{@post.id}/reactions", params: { post_reaction: { reaction: @reaction } }
      expect {
        post "/posts/#{@post.id}/reactions", params: { post_reaction: { reaction: @reaction } }
      }.to change { @post.reactions.count }.by(1)
      expect(response).to be_success
      reaction = PostReaction.last
      expect(reaction.post).to eq(@post)
      expect(reaction.person).to eq(@person)
      expect(reaction.reaction).to eq(@reaction)
    end
    it "should not create a reaction if not logged in" do
      expect {
        post "/posts/#{@post.id}/reactions", params: { post_reaction: { reaction: @reaction } }
      }.to change { PostReport.count }.by(0)
      expect(response).to be_unauthorized
    end
    it "should not create a reaction for a post from a different product" do
      login_as(@person)
      person = create(:person, product: create(:product))
      p = create(:post, person: person)
      expect {
        post "/posts/#{p.id}/reactions", params: { post_reaction: { reaction: @reaction } }
      }.to change { PostReaction.count }.by(0)
      expect(response).to be_not_found
    end
    it "should require valid emoji sequence" do
      login_as(@person)
      nonemoji = "027A1"
      expect {
        post "/posts/#{@post.id}/reactions", params: { post_reaction: { reaction: nonemoji } }
      }.to change { PostReaction.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]["reaction"]).to eq("That emoji code is unknown.")
    end
  end
end
