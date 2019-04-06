require 'rails_helper'

RSpec.describe Api::V1::BlocksController, type: :controller do

  describe "#create" do
    it "should block person"
    it "should kill relationships with person"
    it "should unfollow person"
    it "should be unfollowed blocked person"
    it "should not block person already blocked"
  end
  describe "#destroy" do
    it "should unblock person"
    it "should not unblock if blocker not current user"
  end
end
