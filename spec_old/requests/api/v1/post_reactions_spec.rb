describe "PostReactions (v1)" do

  before(:all) do
    @post = create(:post)
    @person = create(:person, product: @post.product)
    @reaction = "1F600"
  end

  before(:each) do
    logout
  end

  describe "#update" do
    it "should change the reaction to a post if not logged in" do
      reaction = create(:post_reaction, person: @person, reaction: @reaction)
      patch "/posts/#{@post.id}/reactions/#{reaction.id}", params: { post_reaction: { reaction: @reaction } }
      expect(response).to be_unauthorized
      expect(reaction.reload.reaction).to eq(@reaction)
    end
  end
end
