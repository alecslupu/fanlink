describe "PostReactions (v1)" do

  before(:all) do
    @post = create(:post)
    @person = create(:person, product: @post.product)
    @reaction = "1F600"
  end

  before(:each) do
    logout
  end

  describe "#create" do
    it "should create a new reaction" do
      login_as(@person)
      expect {
        post "/posts/#{@post.id}/reactions", params: { post_reaction: { reaction: @reaction } }
      }.to change { @post.reactions.count }.by(1)
      expect(response).to be_success
      reaction = PostReaction.last
      # expect(json["post_reaction"]).to eq(post_reaction_json(reaction))
      expect(post_reaction_json(json["post_reaction"])).to be true
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
      nonemoji = "11FFFF"
      expect {
        post "/posts/#{@post.id}/reactions", params: { post_reaction: { reaction: nonemoji } }
      }.to change { PostReaction.count }.by(0)
      expect(response).to be_unprocessable
      expect(json["errors"]).to include("Reaction is not a valid value.")
    end
  end

  describe "#destroy" do
    it "should delete a reaction" do
      reaction = create(:post_reaction, person: @person)
      login_as(@person)
      expect {
        delete "/posts/#{reaction.post.id}/reactions/#{reaction.id}"
      }.to change { PostReaction.count }.by(-1)
      expect(response).to be_success
      expect(reaction).not_to exist_in_database
    end
    it "should not delete a reaction if not logged in" do
      reaction = create(:post_reaction, person: @person)
      expect {
        delete "/posts/#{reaction.post.id}/reactions/#{reaction.id}"
      }.to change { PostReaction.count }.by(0)
      expect(response).to be_unauthorized
      expect(reaction).to exist_in_database
    end
    it "should not delete a reaction of someone else" do
      reaction = create(:post_reaction, person: create(:person, product: @person.product))
      login_as(@person)
      expect {
        delete "/posts/#{reaction.post.id}/reactions/#{reaction.id}"
      }.to change { PostReaction.count }.by(0)
      expect(response).to be_not_found
      expect(reaction).to exist_in_database
    end
  end
  describe "#update" do
    it "should change the reaction to a post" do
      reaction = create(:post_reaction, person: @person, reaction: "1F601")
      login_as(@person)
      patch "/posts/#{@post.id}/reactions/#{reaction.id}", params: { post_reaction: { reaction: @reaction } }
      expect(response).to be_success
      expect(reaction.reload.reaction).to eq(@reaction)
      # expect(json["post_reaction"]).to eq(post_reaction_json(reaction))
      expect(post_reaction_json(json["post_reaction"])).to be true
    end
    it "should change the reaction to a post if not logged in" do
      reaction = create(:post_reaction, person: @person, reaction: @reaction)
      patch "/posts/#{@post.id}/reactions/#{reaction.id}", params: { post_reaction: { reaction: @reaction } }
      expect(response).to be_unauthorized
      expect(reaction.reload.reaction).to eq(@reaction)
    end
    it "should not change the reaction of someone else" do
      reaction = create(:post_reaction, person: create(:person, product: @person.product), reaction: @reaction)
      login_as(@person)
      patch "/posts/#{@post.id}/reactions/#{reaction.id}", params: { post_reaction: { reaction: "1F601" } }
      expect(response).to be_not_found
      expect(reaction.reload.reaction).to eq(@reaction)
    end
  end
end
