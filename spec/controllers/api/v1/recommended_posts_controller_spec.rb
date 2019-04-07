require 'rails_helper'

RSpec.describe Api::V1::RecommendedPostsController, type: :controller do

  describe "#index" do
    it "should get all recommended posts"
    it "should get page 1 of recommended posts"
    it "should get page 2 of recommended posts"
    it "should return unauthorized if not logged in"
  end
end
