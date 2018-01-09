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
      expect(json["following"]).to eq(following_json(Following.last, follower))
    end
    it "should 404 if trying to follow someone who doesn't exist" do
      follower = create(:person)
      followee_id = Person.last.try(:id).to_i + 1
      login_as(follower)
      post "/followings", params: { followed_id: followee_id }
      expect(response).to be_not_found
    end
    it "should 401 if not logged in" do
      followee = create(:person)
      post "/followings", params: { followed_id: followee.id }
      expect(response).to be_unauthorized
    end
  end

  describe "#destroy" do
    it "should unfollow someone" do
      follower = create(:person)
      followee = create(:person, product: follower.product)
      following = follower.follow(followee)
      expect(follower.following?(followee)).to be_truthy
      login_as(follower)
      delete "/followings/#{following.id}"
      expect(response).to be_success
      expect(follower.following?(followee)).to be_falsey
      expect(following).not_to exist_in_database
    end
    it "should 404 if trying to delete a nonexistent following" do
      follower = create(:person)
      nonexistent = Following.last.try(:id).to_i + 1
      login_as(follower)
      delete "/followings/#{nonexistent}"
      expect(response).to be_not_found
    end
    it "should 401 if not logged in" do
      following = create(:following)
      delete "/followings/#{following.id}"
      expect(response).to be_unauthorized
    end
  end

  describe "#index" do
    it "should get the followers of someone if followed_id passed as param" do
      followed = create(:person)
      login_as(followed)
      followee1 = create(:person, product: followed.product)
      followee2 = create(:person, product: followed.product)
      followee1.follow(followed)
      followee2.follow(followed)
      create(:person, product: followed.product) #someone not following
      get "/followings", params: { followed_id: followed.id.to_s }
      expect(response).to be_success
      expect(json["followers"].map { |f| f["id"].to_i }.sort).to eq([followee1.id, followee2.id].sort)
    end
    it "should get the followeds of someone if follower_id passed as param" do
      follower = create(:person)
      login_as(follower)
      followed1 = create(:person, product: follower.product)
      followed2 = create(:person, product: follower.product)
      follower.follow(followed1)
      follower.follow(followed2)
      create(:person, product: follower.product) #someone not follower
      get "/followings", params: { follower_id: follower.id.to_s }
      expect(response).to be_success
      expect(json["following"].map { |f| f["id"].to_i }.sort).to eq([followed1.id, followed2.id].sort)
    end
    it "should get the followeds of someone if nothing is passed as param" do
      follower = create(:person)
      login_as(follower)
      followed1 = create(:person, product: follower.product)
      followed2 = create(:person, product: follower.product)
      follower.follow(followed1)
      follower.follow(followed2)
      create(:person, product: follower.product) #someone not follower
      get "/followings"
      expect(response).to be_success
      expect(json["following"].map { |f| f["id"].to_i }.sort).to eq([followed1.id, followed2.id].sort)
    end
    it "should 404 if followed_id is from another product" do
      logged_in = create(:person)
      login_as(logged_in)
      other = create(:person, product: create(:product))
      followee1 = create(:person, product: other.product)
      followee1.follow(other)
      get "/followings", params: { followed_id: other.id.to_s }
      expect(response).to be_not_found
    end
    it "should 401 if not logged in" do
      get "/followings", params: { followed_id: create(:person).id.to_s }
      expect(response).to be_unauthorized
    end
  end
end
