require 'rails_helper'

RSpec.describe Api::V1::FollowingsController, type: :controller do

  describe "#create" do
    it "should follow someone"
    it "should 404 if trying to follow someone who does not exist"
    it "should 401 if not logged in"
  end

  describe "#destroy" do
    it "should unfollow someone"
    it "should 404 if trying to delete a nonexistent following"
    it "should 401 if not logged in"
  end

  describe "#index" do
    it "should get the followers of someone if followed_id passed as param"
    it "should get the followeds of someone if follower_id passed as param"
    it "should get the followeds of someone if nothing is passed as param"
    it "should 404 if followed_id is from another product"
    it "should 401 if not logged in"
  end
end
