require "rails_helper"

RSpec.describe Api::V1::PostReactionsController, type: :controller do

  describe "#create" do
    it "should create a new reaction"
    it "should not create a reaction if not logged in"
    it "should not create a reaction for a post from a different product"
    it "should require valid emoji sequence"
  end

  describe "#destroy" do
    it "should delete a reaction"
    it "should not delete a reaction if not logged in"
    it "should not delete a reaction of someone else"
  end

  describe "#update" do
    it "should change the reaction to a post"
    it "should change the reaction to a post if not logged in"
    it "should not change the reaction of someone else"
  end
end
