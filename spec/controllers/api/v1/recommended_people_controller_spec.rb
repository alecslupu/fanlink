require 'rails_helper'

RSpec.describe Api::V1::RecommendedPeopleController, type: :controller do

  describe "#index" do
    it "should get all recommended people"
    it "should exclude the current user"
    it "should exclude followees of the current user"
  end
end
