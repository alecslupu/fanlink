require "spec_helper"

RSpec.describe Api::V2::MessagesController, type: :controller do
  describe "index" do
    it "should get a paginated list of messages with page 1"
    it "should get only pinned messages with page 1"
    it "should get only nonpinned messages"
    it "should get all pinned and nonpinned messages"
  end
end
