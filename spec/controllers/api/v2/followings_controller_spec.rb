require "spec_helper"

RSpec.describe Api::V2::FollowingsController, type: :controller do
  describe "#create" do
    it "should 401 if not logged in" do
      followee = create(:person)
      ActsAsTenant.with_tenant(followee.product) do
        post :create, params: { followed_id: followee.id }
        expect(response).to have_http_status(401)
      end
    end

    it "should follow someone" do
      follower = create(:person)
      ActsAsTenant.with_tenant(follower.product) do
        followee = create(:person)
        login_as(follower)
        expect(follower.following?(followee)).to be_falsey
        post :create, params: { followed_id: followee.id }
        expect(response).to have_http_status(200)
        expect(follower.following?(followee)).to be_truthy
        expect(following_json(json["following"])).to be_truthy
      end
    end

    it "should 404 if trying to follow someone who does not exist" do
      follower = create(:person)
      ActsAsTenant.with_tenant(follower.product) do
        followee_id = follower.id + 1
        login_as(follower)
        post :create, params: { followed_id: followee_id }
        expect(response).to have_http_status(404)
      end
    end
  end

  describe "#destroy" do
    it "should unfollow someone" do
      following = create(:following)
      ActsAsTenant.with_tenant(following.followed.product) do
        login_as(following.follower)
        expect(following.follower.following?(following.followed)).to be_truthy
        post :destroy, params: { id: following.id }
        expect(response).to have_http_status(200)
        expect(following.follower.following?(following.followed)).to be_falsey
        expect(following).not_to exist_in_database
      end
    end
    it "should 404 if trying to delete a nonexistent following" do
      following = create(:following)
      ActsAsTenant.with_tenant(following.followed.product) do
        login_as(following.follower)
        post :destroy, params: { id: following.id + 1 }
        expect(response).to have_http_status(404)
      end
    end
    it "should 401 if not logged in" do
      following = create(:following)
      ActsAsTenant.with_tenant(following.followed.product) do
        post :destroy, params: { id: following.id }
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "#index" do
    it "should get the followers of someone if followed_id passed as param" do
      followed = create(:person)
      ActsAsTenant.with_tenant(followed.product) do
        login_as(followed)
        followee1 = create(:person)
        followee2 = create(:person)
        followee1.follow(followed)
        followee2.follow(followed)
        create(:person) # someone not following
        get :index, params: { followed_id: followed.id.to_s }
        expect(response).to be_successful
        expect(json["followers"].map { |f| f["id"].to_i }.sort).to eq([followee1.id, followee2.id].sort)
      end
    end
    it "should get the followeds of someone if follower_id passed as param" do
      follower = create(:person)
      ActsAsTenant.with_tenant(follower.product) do
        login_as(follower)
        followed1 = create(:person)
        followed2 = create(:person)
        follower.follow(followed1)
        follower.follow(followed2)
        create(:person) # someone not follower
        get :index, params: { follower_id: follower.id.to_s }
        expect(response).to be_successful
        expect(json["following"].map { |f| f["id"].to_i }.sort).to eq([followed1.id, followed2.id].sort)
      end
    end
    it "should get the followeds of someone if nothing is passed as param" do
      person = create(:person)
      ActsAsTenant.with_tenant(person.product) do
        login_as(person)
        followees = create_list(:following, 2, follower: person)

        create(:person) # someone not follower
        get :index
        expect(response).to be_successful
        expect(json["following"].map { |f| f["id"].to_i }.sort).to eq(followees.map(&:followed_id).sort)
      end
    end
    it "should 404 if followed_id is from another product" do
      person = create(:person)
      other = create(:person, product: create(:product))
      ActsAsTenant.with_tenant(person) do
        person.follow(other)
        login_as(person)
        get :index, params: { followed_id: other.id.to_s }
        expect(response).to have_http_status(404)
      end
    end
    it "should 401 if not logged in" do
      person = create(:person)
      ActsAsTenant.with_tenant(person) do
        get :index, params: { followed_id: person.id }
        expect(response).to have_http_status(401)
      end
    end
  end
end
