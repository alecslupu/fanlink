require 'rails_helper'

RSpec.describe Api::V1::RoomMembershipsController, type: :controller do

  describe "#create" do
    it "should make someone a member if current user owns the room"
    it "should not create membership if already a member"
    it "should not make someone a member if room is inactive"
    it "should not make someone a member if room is public"
  end
end
