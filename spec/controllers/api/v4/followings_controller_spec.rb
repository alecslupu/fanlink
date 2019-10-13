require 'rails_helper'

RSpec.describe Api::V4::FollowingsController, type: :controller do

  # TODO: auto-generated
  describe 'GET index' do
    it "should get all the followers of someone if no pagination param is given" do
      followed = create(:person)
      ActsAsTenant.with_tenant(followed.product) do
        login_as(followed)
        follower1 = create(:person)
        follower2 = create(:person)
        follower1.follow(followed)
        follower2.follow(followed)
        create(:person) # not following

        get :index, params: { followed_id: followed.id.to_s }

        expect(response).to be_successful
        expect(json["followers"].map { |f| f["id"].to_i }.sort).to eq([follower1.id, follower2.id].sort)
      end
    end

    it "should paginate response with two followers per page" do
      followed = create(:person)

      ActsAsTenant.with_tenant(followed.product) do
        login_as(followed)
        follower1 = create(:person)
        follower2 = create(:person)
        follower3 = create(:person)
        follower1.follow(followed)
        follower2.follow(followed)
        follower3.follow(followed)
        create(:person) # not following

        get :index, params: { followed_id: followed.id.to_s, page: 1, per_page: 2 }

        expect(response).to be_successful
        expect(json["followers"].size).to eq(2)
      end
    end

    it "should get all the followed people of someone if no pagination param is given" do
      follower = create(:person)
      ActsAsTenant.with_tenant(follower.product) do
        login_as(follower)
        followed1 = create(:person)
        followed2 = create(:person)
        follower.follow(followed1)
        follower.follow(followed2)
        create(:person) # not following

        get :index, params: { follower_id: follower.id.to_s }

        expect(response).to be_successful
        expect(json["following"].map { |f| f["id"].to_i }.sort).to eq([followed1.id, followed2.id].sort)
      end
    end

    it "should paginate response with two followeds per page" do
      follower = create(:person)

      ActsAsTenant.with_tenant(follower.product) do
        login_as(follower)
        followed1= create(:person)
        followed2 = create(:person)
        followed3 = create(:person)
        follower.follow(followed1)
        follower.follow(followed2)
        follower.follow(followed3)
        create(:person) # not following

        get :index, params: { follower_id: follower.id.to_s, page: 1, per_page: 2 }

        expect(response).to be_successful
        expect(json["following"].size).to eq(2)
      end
    end
  end
  # # TODO: auto-generated
  # describe 'POST create' do
  #   pending
  # end
end
