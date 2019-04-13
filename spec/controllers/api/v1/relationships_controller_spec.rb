require "rails_helper"

RSpec.describe Api::V1::RelationshipsController, type: :controller do

  describe "#create" do
    it "should send a friend request to someone"
    it "should not send a friend request to someone you have blocked"
    it "should not send a friend request to someone who has blocked you"
    it "should just change request to friended if to person sends a new request to from person"
    it "should 404 if trying to befriend someone who does not exist"
    it "should 401 if not logged in"
  end

  describe "#destroy" do
    it "should unfriend a friend"
    it "should not unfriend another couple of friends"
    it "should not unfriend a friend who only has a request"
  end

  describe "#index" do
    it "should get the current relationships of other user"
    it "should get the current and pending relationships of current user"
    it "should get the current and pending relationships of current user with no param"
    it "should 401 if not logged in"
  end

  describe "#show" do
    it "should get a single relationship"
    it "should not get relationship if not logged in"
    it "should not get relationship if not a part of it"
    it "should not get relationship if relationship denied or withdrawn or unfriended"
  end

  describe "#update" do
    it "should accept a friend request"
    it "should not accept own friend request"
    it "should not accept a friend request if status not appropriate status"
    it "should deny a friend request"
    it "should withdraw a friend request"
    it "should not update with an invalid status"
  end
end
