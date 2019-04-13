require "rails_helper"

RSpec.describe Api::V1::PostCommentsController, type: :controller do

  describe "#create" do
    it "should create a post comment"
    it "should create a post comment with one mention"
    it "should create a post comment with multiple mentions"
    it "should not create a post comment if not logged in"
    it "should not create a post comment if logged in to a different product"
  end

  describe "#destroy" do
    it "should delete a comment by an admin"
    it "should delete a comment by creator"
    it "should not delete a comment by other than creator or admin"
    it "should not delete a comment from another product by admin"
    it "should not delete a comment if not logged in"
  end

  describe "#index" do
    it "should get the first page of the comments for a post"
    it "should get all the comments for a post without comments"
  end


  describe "#list" do
    it "should get the paginated list of all comments unfiltered"
    it "should get list of comments paginated at page 2"
    it "should get the list of all post comments filtered on body"
    it "should get the list of all post comments filtered on full person username match"
    it "should get the list of all post comments filtered on partial person username match"
    it "should get the list of all post comments filtered on full person email match"
    it "should get the list of all post comments filtered on partial person email match"
  end
end
