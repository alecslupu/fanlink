describe "Followings (v1)" do

  before(:each) do
    logout
  end

  describe "#create" do
    it "should follow someone" do
      follower = create(:person)
      followee = create(:person, product: follower.product)
      login_as(follower)
      expect(follower.following?(followee)).to be_falsey
      post "/followings", params: { followed_id: followee.id }
      expect(response).to be_success
      expect(follower.following?(followee)).to be_truthy
    end
  end

  describe "#destroy" do
    it "should unfollow someone" do
      follower = create(:person)
      followee = create(:person, product: follower.product)
      follower.follow(followee)
      expect(follower.following?(followee)).to be_truthy
      login_as(follower)
      delete "/followings", params: { followed_id: followee.id }
      expect(response).to be_success
      expect(follower.following?(followee)).to be_falsey
    end
  end

end