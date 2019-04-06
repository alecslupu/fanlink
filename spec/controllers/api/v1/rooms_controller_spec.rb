require 'rails_helper'

RSpec.describe Api::V1::RoomsController, type: :controller do

  describe "#create" do
    it "should not create a private room if not logged in"
    it "should create a private room with a list of members and make it active"
    it "should not include blocked users in private room"
  end

  describe "#destroy" do
    it "should completely destroy room without messages"
    it "should not delete room if not room owner"
    it "should mark room deleted if it has messages"
  end

  describe "#index" do
    it "should get a list of active public rooms when private param not specified"
    it "should get a list of active public rooms when private param is false"
    it "should get a list of active private rooms of which user is a member when private param is true"
  end

  describe "#update" do
    it "should let room owner update room name"
    it "should not let room nonowner update room name"
  end
end
